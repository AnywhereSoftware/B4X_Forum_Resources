/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2016 Fouad Almalki
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

package io.fouad.jtb.core.beans;

import java.util.Arrays;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * This object represents a chat.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class Poll
{
	/**
	 * Unique identifier for this poll. 
	 */
	@JsonProperty("id")
	private long id;
	
	/**
	 * Poll question, 1-255 characters
	 */
	@JsonProperty("question")
	private String question;
	
	@JsonProperty("is_closed")
	private Boolean is_closed;
	
	/**
	 * Optional. A chat photo was change to this value.
	 */
	@JsonProperty("options")
	private PollOption[] options;

	
	public Poll(){}
	
	public Poll(long id, String question, Boolean isClosed, PollOption[] options)
	{
		this.id = id;
		this.question = question;
		this.is_closed = isClosed;
		this.options = options;
	}
	
	public long getId(){return id;}
	public String getQuestion(){return question;}
	public PollOption[] getOptions(){return options;}
	public Boolean getClosed(){return is_closed;}
	
	@Override
	public boolean equals(Object o)
	{
		if(this == o) return true;
		if(o == null || getClass() != o.getClass()) return false;
		
		Poll chat = (Poll) o;
		
		if(id != chat.id) return false;
		if(question != chat.question) return false;
		if(is_closed != chat.is_closed) return false;
		return true;
	}
	
	@Override
	public int hashCode()
	{
		int result = (int) (id ^ (id >>> 32));
		result = 31 * result + (question != null ? question.hashCode() : 0);
		result = 31 * result + (is_closed != null ? is_closed.hashCode() : 0);
		return result;
	}
	
	@Override
	public String toString()
	{
		return "Poll{" +
				"id=" + id +
				", question=" + question +
				", options=" + Arrays.deepToString(options) +
					", is_closed='" + is_closed + '\'' +
				'}';
	}
}