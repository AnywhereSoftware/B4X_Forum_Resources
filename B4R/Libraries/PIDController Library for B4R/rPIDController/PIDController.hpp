/***************************************************
PIDController - Version 2.6.0
Copyright (c) 2021 Luis Llamas (www.luisllamas.es)

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

This library is licensed under a GPLv3 License
You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses>
****************************************************/

// BASED ON:
// (discontinued, thanks for your great work Brett):
/**********************************************************************************************
 * Arduino PID Library - Version 1.2.1
 * by Brett Beauregard <br3ttb@gmail.com> brettbeauregard.com
 *
 * This Library is licensed under a GPLv3 License
 **********************************************************************************************/

#ifndef __PID_LIBRARY_h__
#define __PID_LIBRARY_h__

#define __PID_LIBRARY_VERSION__	2.6.0

#include "Arduino.h"


namespace PID
{
	enum MODE { MANUAL, AUTOMATIC };
	enum DIRECTION { DIRECT, REVERSE };
	enum PROPORTIONAL_ON { MEASURE, ERROR };
	enum RESOLUTION { MILLIS, MICROS };

	template <typename T>
	class IController
	{
	public:
		virtual ~IController() = default;
		
		virtual bool Update() = 0;

		virtual bool Update(T input) = 0;

		virtual void ForceUpdate() = 0;

		virtual void ForceUpdate(T input) = 0;

		virtual bool IsTurnedOn() = 0;

		virtual void TurnOn(bool reset = true) = 0;

		virtual void TurnOff() = 0;

		virtual void Toggle() = 0;
	};


	template <typename T>
	class ISisoController : public IController<T>
	{
	public:
		T Input;
		T Output;
		T Setpoint;
	};


	template <typename T>
	class PIDParameters
	{
	public:
		PIDParameters() : Kp(T(0)), Ki(T(0)), Kd(T(0))
		{
		}

		PIDParameters(T kp, T ki, T kd) : Kp(kp), Ki(ki), Kd(kd)
		{
		}

		T Kp;
		T Ki;
		T Kd;

		bool HasNegatives()
		{
			return (Kp < 0 || Ki < 0 || Kd < 0);
		}

		void Set(PIDParameters<T> parameters)
		{
			Set(parameters.Kp, parameters.Ki, parameters.Kd);
		}

		void Set(T kp, T ki, T kd)
		{
			Kp = kp;
			Ki = ki;
			Kd = kd;
		}

		void Invert()
		{
			Kp = (0 - Kp);
			Ki = (0 - Ki);
			Kd = (0 - Kd);
		}

		static PIDParameters Linear(PIDParameters from, PIDParameters to, float t)
		{
			return
			{
				from.Kp + (to.Kp - from.Kp) * t,
				from.Ki + (to.Ki - from.Ki) * t,
				from.Kd + (to.Kd - from.Kd) * t,
			};
		}
	};


	template <typename T>
	class PIDParametersAdaptative
	{
	public:
		PIDParametersAdaptative(T near_distance, PIDParameters<T> near_parameter, T far_distance, PIDParameters<T> far_parameter)
			: NearParameter(near_parameter), NearDistance(near_distance), FarParameter(far_parameter), FarDistance(far_distance)
		{
		}

		PIDParameters<T> NearParameter;
		T NearDistance;

		PIDParameters<T> FarParameter;
		T FarDistance;

		PIDParameters<T> GetAt(T distance)
		{
			distance = distance >= 0 ? distance : -distance;
			if (distance < NearDistance) return NearParameter;
			if (distance > FarDistance) return FarParameter;

			auto relative_distance = (distance - NearDistance) / (FarDistance - NearDistance);
			return PIDParameters<T>::Linear(NearParameter, FarParameter, relative_distance);
		}
	};


	template <typename T>
	class PIDController : public ISisoController<T>
	{
	public:
		explicit PIDController(PIDParameters<T> pid_parameters, const DIRECTION direction = DIRECTION::DIRECT)
		{
			Parameters_original.Set(pid_parameters);
			Direction = direction;
			ComputeParameters();

			Last_time = GetTime() - Sample_time;
		}

		void SetProportionalOn(const PROPORTIONAL_ON proportional_on)
		{
			Proportional_On = proportional_on;
		}

		void SetOutputLimits(const T output_min, const T output_max)
		{
			SetOutputLimits(output_min, output_max, output_min, output_max);
		}

		void SetOutputLimits(const T output_min, const T output_max, const T windup_guard_min, const T windup_guard_max)
		{
			if (output_min >= output_max) return;
			if (windup_guard_min >= windup_guard_max) return;
		
			Output_min = output_min;
			Output_max = output_max;
			Output_sum_min = windup_guard_min;
			Output_sum_max = windup_guard_max;

			if (IsTurnedOn())
			{
				this->Output = Clamp(this->Output, Output_min, Output_max);
				Output_sum = Clamp(Output_sum, Output_sum_min, Output_sum_max);
			}
		}

		void SetTunings(PIDParameters<T> pid_parameters)
		{
			if (pid_parameters.HasNegatives()) return;

			Parameters_original.Set(pid_parameters);
			ComputeParameters();
		}

		void SetDirection(const DIRECTION direction)
		{
			if (Direction == direction) return;

			Direction = direction;
			ComputeParameters();
		}

		void SetSampleTime(unsigned long sample_time)
		{
			if (sample_time <= 0) return;

			Sample_time = sample_time;
			ComputeParameters();
		}

		void TurnOn(bool reset = true) override { SetMode(MODE::AUTOMATIC, reset); }

		void TurnOff() override { SetMode(MODE::MANUAL); }

		void Toggle() override
		{
			if (IsTurnedOn()) TurnOff();
			else TurnOn();
		}


		T GetError() { return this->Setpoint - this->Input; }

		T GetKp() { return Parameters_original.Kp; }

		T GetKi() { return Parameters_original.Ki; }

		T GetKd() { return Parameters_original.Kd; }

		T GetCorrectedKp() { return Parameters_corrected.Kp; }

		T GetCorrectedKi() { return Parameters_corrected.Ki; }

		T GetCorrectedKd() { return Parameters_corrected.Kd; }

		T GetTermP() { return TermP; }

		T GetTermI() { return TermI; }

		T GetTermD() { return TermD; }

		
		T GetOutputMin() { return Output_min; }

		T GetOutputMax() { return Output_max; }

		T GetWindupGuardMin() { return Output_sum_min; }

		T GetWindupGuardMax() { return Output_sum_max; }


		DIRECTION GetDirection() const { return Direction; }

		PROPORTIONAL_ON GetProportionalOn() const { return Proportional_On; }

		bool IsTurnedOn() override { return Mode == MODE::AUTOMATIC; }

		bool Update() override
		{
			if (IsTurnedOn() == false) return false;

			const auto now = GetTime();
			const auto time_change = (now - Last_time);
			if (time_change >= Sample_time)
			{
				UpdatePID();

				Last_time = now;
				return true;
			}
			else return false;
		}

		bool Update(T input) override
		{
			this->Input = input;
			return Update();
		}

		void ForceUpdate() override
		{
			if (IsTurnedOn() == false) return;

			const auto saved_sample_time = Sample_time;
			const auto now = GetTime();
			const auto time_change = (now - Last_time);
			SetSampleTime(time_change);

			UpdatePID();

			SetSampleTime(saved_sample_time);
			Last_time = GetTime();
		}

		void ForceUpdate(T input) override
		{
			this->Input = input;
			return ForceUpdate();
		}


	private:
		void ComputeParameters()
		{
			Parameters_corrected.Set(Parameters_original);

			T sample_time_in_sec = static_cast<T>(Sample_time) / (Resolution == RESOLUTION::MILLIS ? 1000 : 1000000);

			Parameters_corrected.Ki *= sample_time_in_sec;
			Parameters_corrected.Kd /= sample_time_in_sec;

			if (Direction == REVERSE)
				Parameters_corrected.Invert();
		}

		void SetMode(const MODE mode, bool reset = false)
		{
			if (Mode == mode) return;
			Mode = mode;

			if (IsTurnedOn())
				Initialize(reset);
		}

		void Initialize(bool reset = true)
		{
			IsFirstInput = true;
			Last_input = this->Input;
			Output_sum = reset ? 0 : this->Output;

			Output_sum = Clamp(Output_sum, Output_sum_min, Output_sum_max);
		}

		void UpdatePID()
		{
			T error = GetError();
			T diff_input = IsFirstInput ? 0 : this->Input - Last_input;

			TermP = Proportional_On == PROPORTIONAL_ON::ERROR ? Parameters_corrected.Kp * error : Parameters_corrected.Kp * diff_input;
			TermI = Parameters_corrected.Ki * (error + Last_error) / 2;
			TermD = - Parameters_corrected.Kd * diff_input;

			if (Proportional_On == PROPORTIONAL_ON::ERROR)
			{
				 this->Output = TermP;
			}
			else
			{
				Output_sum -= TermP;
				this->Output = 0;
			}

			Output_sum += TermI;
			Output_sum = Clamp(Output_sum, Output_sum_min, Output_sum_max);

			this->Output += Output_sum + TermD;
			this->Output = Clamp(this->Output, Output_min, Output_max);

			IsFirstInput = false;
			Last_error = error;
			Last_input = this->Input;
		}

		unsigned long GetTime() const
		{
			return Resolution == MILLIS ? millis() : micros();
		}

		static constexpr T Clamp(T x, T min, T max)
		{
			return (x < min) ? min : ((x > max) ? max : x);
		}

		PIDParameters<T> Parameters_original;
		PIDParameters<T> Parameters_corrected;

		T Output_min = 0;
		T Output_max = 255.0;
		T Output_sum;

		T Output_sum_min = 0;
		T Output_sum_max = 255.0;

		T TermP;
		T TermI;
		T TermD;

		bool IsFirstInput;
		T Last_input;
		T Last_error;
		unsigned long Last_time;
		unsigned long Sample_time = 100;

		MODE Mode = MODE::MANUAL;
		DIRECTION Direction = DIRECTION::DIRECT;
		PROPORTIONAL_ON Proportional_On = PROPORTIONAL_ON::MEASURE;
		RESOLUTION Resolution = RESOLUTION::MILLIS;
	};
}

#endif