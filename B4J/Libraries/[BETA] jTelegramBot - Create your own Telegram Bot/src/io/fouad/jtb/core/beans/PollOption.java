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

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * This object represents a Telegram user or bot.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class PollOption
{
	/**
	 * Unique identifier for this user or bot.
	 */
	@JsonProperty("voter_count")
	private int voter_count;
	
	@JsonProperty("text")
	private String text;
	
	
	public PollOption(){}
	
	public PollOption(int count, String text)
	{
		this.text = text;
		this.voter_count = count;
	}
	
	public int getCount(){return voter_count;}
	public String getText(){return text;}
	
	@Override
	public boolean equals(Object o)
	{
		if(this == o) return true;
		if(o == null || getClass() != o.getClass()) return false;
		
		PollOption user = (PollOption) o;
		
		if(text != null ? !text.equals(user.text) : user.text != null) return false;
		return true;
	}
	
	@Override
	public int hashCode()
	{
		int result = voter_count;
		result = 31 * result + (text != null ? text.hashCode() : 0);
		return result;
	}
	
	@Override
	public String toString()
	{
		return "User{" +
				"voter_count=" + voter_count +
				", text='" + text + '\'' +
				'}';
	}
}