package com.woori.dto;

public class CancelReasonDTO
{
	private String crc_code;
	private String crc_reason;
	
	// getter / setter 구성
	public String getCrc_code()
	{
		return crc_code;
	}
	public void setCrc_code(String crc_code)
	{
		this.crc_code = crc_code;
	}
	public String getCrc_reason()
	{
		return crc_reason;
	}
	public void setCrc_reason(String crc_reason)
	{
		this.crc_reason = crc_reason;
	}

}
