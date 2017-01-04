<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 */
class Setting_model
{	
	/**
	 * CI_DB_query_builder
	 * @var CI_DB_query_builder 
	 */
	private $db;
	
	function __construct()
	{
		// Get Current Instance
		$CI =& get_instance();
		
		// Assign DB Object
		$this->db = $CI->db;
	}
	/**
	 * Get setting value
	 * @param type $key
	 * @param mixed $cast_as 'int', 'bool', 'float', 'string' Default: dari value_type
	 */
	function get_value($key, $cast_as = NULL)
	{	
		$row = $this->db->get_where('setting', array('key' => $key))->row();
		
		if ($row)
		{
			if ($cast_as == NULL)
				$cast_as = $row->value_type;
			
			switch ($cast_as)
			{
				case 'string':	return (string)$row->value; break;
				case 'integer':	return (integer)$row->value; break;
				case 'double':	return (double)$row->value; break;
				case 'boolean':	return (boolean)$row->value; break;
			}
		}
		else
		{
			return NULL;
		}
	}
	
	function set_value($key, $value, $cast_as = NULL)
	{
		// Get row whetever exist
		$row = $this->db->get_where('setting', array('key' => $key))->row();
		
		if ($cast_as == NULL)
		{
			$cast_as = gettype($value);
		}
		// Change format boolean ke 1/0
		else if ($cast_as == 'boolean')
		{
			if ($value == TRUE) 
				$value = 1;
			else 
				$value = 0;
		}
		
		// Not exist --> INSERT
		if ( ! $row)
		{
			return $this->db->insert('setting', array(
				'key'		 => $key,
				'value'		 => $value,
				'value_type' => $cast_as
			));
		}
		// Exist --> UPDATE
		else
		{
			return $this->db->update('setting', array(
				'value'		 => $value,
				'value_type' => $cast_as
			), array('key' => $key));
		}
	}
}
