/*
 * Copyright (c) 2003-2015, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package types;

import types.DataType;

import cpp.Lib;

@:buildXml('

	<files id="haxe">

		<include name="${haxelib:duell_types}/backends/types_cpp/native.xml" />

	</files>

')

@:headerCode("
#include <types/NativeData.h>
")

@:cppFileCode('

#include <string>
#include <sstream>
#include <stdio.h>

static inline std::wstring staticReadValueIntoString(void *pointer, types::DataType &dataType)
{
	std::wostringstream oss;
	switch( (int)(dataType->__Index())){
		case (int)0: {
			oss << (int)(((int8_t*)pointer)[0]);
		}
		;break;
		case (int)1: {
			oss << (int)(((uint8_t*)pointer)[0]);
		}
		;break;
		case (int)2: {
			oss << (int)(((int16_t*)pointer)[0]);
		}
		;break;
		case (int)3: {
			oss << (int)(((uint16_t*)pointer)[0]);
		}
		;break;
		case (int)4: {
			oss << ((int32_t*)pointer)[0];
		}
		;break;
		case (int)5: {
			oss << ((uint32_t*)pointer)[0];
		}
		;break;
		case (int)6: {
			#ifdef __arm__ /// ARM DOESNT LIKE UNLIGNED
			if ((((intptr_t)pointer) & 0x3) == 0)
			{
			#endif
				oss << ((float*)pointer)[0];
			#ifdef __arm__
			}
			else
			{
				float f;
				memcpy(&f, pointer, sizeof(float));
				oss << f;
			}
			#endif

		}
		;break;
		case (int)7: {
			#ifdef __arm__
			if ((((intptr_t)pointer) & 0x7) == 0)
			{
			#endif
				oss << ((double*)pointer)[0];
			#ifdef __arm__
			}
			else
			{
				double d;
				memcpy(&d, pointer, sizeof(double));
				oss << d;
			}
			#endif
		}
		;break;
	}
	return oss.str();
}


static inline void staticWriteFloatIntoPointer(void *pointer, double value, types::DataType &dataType)
{
	switch( (int)(dataType->__Index())){
		case (int)0: {
			((int8_t*)pointer)[0] = (int8_t)value;
		}
		;break;
		case (int)1: {
			((uint8_t*)pointer)[0] = (uint8_t)value;
		}
		;break;
		case (int)2: {
			((int16_t *)pointer)[0] = (int16_t)value;
		}
		;break;
		case (int)3: {
			((uint16_t *)pointer)[0] = (uint16_t)value;
		}
		;break;
		case (int)4: {
			((int32_t *)pointer)[0] = (int32_t)value;
		}
		;break;
		case (int)5: {
			((uint32_t *)pointer)[0] = (uint32_t)value;
		}
		;break;
		case (int)6: {
			#ifdef __arm__
			if ((((intptr_t)pointer) & 0x3) == 0)
			{
			#endif
				((float *)pointer)[0] = (float)value;
			#ifdef __arm__
			}
			else
			{
				float floatValue = (float)value;
				memcpy(pointer, &floatValue, sizeof(float));
			}
			#endif
		}
		;break;
		case (int)7: {
			#ifdef __arm__
			if ((((intptr_t)pointer) & 0x7) == 0)
			{
			#endif
				((double *)pointer)[0] = (double)value;
			#ifdef __arm__
			}
			else
			{
				memcpy(pointer, &value, sizeof(double));
			}
			#endif
		}
		;break;
	}
}

static inline float staticReadFloatFromPointer(void *pointer, types::DataType &dataType)
{
	switch( (int)(dataType->__Index())){
		case (int)0: {
			return (float)(((int8_t*)pointer)[0]);
		}
		case (int)1: {
			return (float)(((uint8_t*)pointer)[0]);
		}
		case (int)2: {
			return (float)(((int16_t*)pointer)[0]);
		}
		case (int)3: {
			return (float)(((uint16_t*)pointer)[0]);
		}
		case (int)4: {
			return (float)(((int32_t*)pointer)[0]);
		}
		case (int)5: {
			return (float)(((uint32_t*)pointer)[0]);
		}
		case (int)6: {
			#ifdef __arm__
			if ((((intptr_t)pointer) & 0x3) == 0)
			{
			#endif
				return ((float*)pointer)[0];
			#ifdef __arm__
			}
			else
			{
				float f;
				memcpy(&f, pointer, sizeof(float));
				return f;
			}
			#endif
		}
		case (int)7: {
			#ifdef __arm__
			if ((((intptr_t)pointer) & 0x7) == 0)
			{
			#endif
				return ((double*)pointer)[0];
			#ifdef __arm__
			}
			else
			{
				double d;
				memcpy(&d, pointer, sizeof(double));
				return d;
			}
			#endif
		}
	}
	return 0;
}

static inline void staticWriteIntIntoPointer(void *pointer, int &value, types::DataType &dataType)
{
	switch( (int)(dataType->__Index())){
		case (int)0: {
			((int8_t*)pointer)[0] = (int8_t)value;
		}
		;break;
		case (int)1: {
			((uint8_t*)pointer)[0] = (uint8_t)value;
		}
		;break;
		case (int)2: {
			((int16_t *)pointer)[0] = (int16_t)value;
		}
		;break;
		case (int)3: {
			((uint16_t *)pointer)[0] = (uint16_t)value;
		}
		;break;
		case (int)4: {
			((int32_t *)pointer)[0] = (int32_t)value;
		}
		;break;
		case (int)5: {
			((uint32_t *)pointer)[0] = (uint32_t)value;
		}
		;break;
		case (int)6: {
			#ifdef __arm__
			if ((((intptr_t)pointer) & 0x3) == 0)
			{
			#endif
				((float *)pointer)[0] = (float)value;
			#ifdef __arm__
			}
			else
			{
				float floatValue = (float)value;
				memcpy(pointer, &floatValue, sizeof(float));
			}
			#endif
		}
		;break;
		case (int)7: {
			#ifdef __arm__
			if ((((intptr_t)pointer) & 0x7) == 0)
			{
			#endif
				((double *)pointer)[0] = (double)value;
			#ifdef __arm__
			}
			else
			{
				double doubleValue = (double)value;
				memcpy(pointer, &doubleValue, sizeof(double));
			}
			#endif
		}
		;break;
	}
}

static inline int staticReadIntFromPointer(void *pointer, types::DataType &dataType)
{
	switch( (int)(dataType->__Index())){
		case (int)0: {
			return (int)(((int8_t*)pointer)[0]);
		}
		case (int)1: {
			return (int)(((uint8_t*)pointer)[0]);
		}
		case (int)2: {
			return (int)(((int16_t*)pointer)[0]);
		}
		case (int)3: {
			return (int)(((uint16_t*)pointer)[0]);
		}
		case (int)4: {
			return (int)(((int32_t*)pointer)[0]);
		}
		case (int)5: {
			return (int)(((uint32_t*)pointer)[0]);
		}
		case (int)6: {
			#ifdef __arm__
			if ((((intptr_t)pointer) & 0x3) == 0)
			{
			#endif
				return ((float*)pointer)[0];
			#ifdef __arm__
			}
			else
			{
				float f;
				memcpy(&f, pointer, sizeof(float));
				return f;

			}
			#endif
		}
		case (int)7: {
			#ifdef __arm__
			if ((((intptr_t)pointer) & 0x7) == 0)
			{
			#endif
				return ((double*)pointer)[0];
			#ifdef __arm__
			}
			else
			{
				double d;
				memcpy(&d, pointer, sizeof(double));
				return d;

			}
			#endif
		}
	}
	return 0;
}


')

@:headerClassCode('
public:
	NativeData *_nativeData; ///this gets dealloced by the GC since it is tied to "nativeData" with alloc_abstract
')

@:keep
class Data
{
	inline static public var SIZE_OF_INT8: Int = 1;
	inline static public var SIZE_OF_UINT8: Int = 1;
	inline static public var SIZE_OF_INT16: Int = 2;
	inline static public var SIZE_OF_UINT16: Int = 2;
	inline static public var SIZE_OF_INT32: Int = 4;
	inline static public var SIZE_OF_UINT32: Int = 4;
	inline static public var SIZE_OF_FLOAT32: Int = 4;
	inline static public var SIZE_OF_FLOAT64: Int = 8;

	/// CONSTRUCTOR
	public function new(sizeInBytes : Int) : Void
	{
        lazyLoadNativeData();

		setupHaxeNativeData();

		if (sizeInBytes != 0)
		{
			setup(sizeInBytes);
		}
	}

	public var nativeData : Dynamic;
    private static var nativedata_createNativeData = null;

    private function lazyLoadNativeData(): Void
    {
        if (nativedata_createNativeData == null)
        {
            nativedata_createNativeData = Lib.load("nativedata", "nativedata_createNativeData", 0);
        }
    }

	@:functionCode("
		nativeData = nativedata_createNativeData();
		_nativeData = (NativeData*)nativeData->__GetHandle();
	")
	private function setupHaxeNativeData() : Void {}

	@:functionCode("
		_nativeData->setup(length);
	")
	private function setup(length : Int) : Void {}

	/// PROPERTIES
	public var allocedLength(get, never) : Int;
	@:functionCode("
		return _nativeData->allocedLength;
	")
	private function get_allocedLength() : Int { return 0; }

	public var offset(get, set) : Int;
	@:functionCode("
		return _nativeData->offset;
	")
	private function get_offset() : Int { return 0; }

	@:functionCode("
		_nativeData->offset = offset;
		return _nativeData->offset;
	")
	private function set_offset(offset : Int) : Int { return 0; }

	public var offsetLength(get, set) : Int;

	@:functionCode("
		return _nativeData->offsetLength;
	")
	private function get_offsetLength() : Int { return 0; }

	@:functionCode("
		_nativeData->offsetLength = offsetLength;
		return _nativeData->offsetLength;
	")
	private function set_offsetLength(offsetLength : Int) : Int { return 0; }

	@:functionCode("
		_nativeData->offsetLength = _nativeData->allocedLength;
		_nativeData->offset = 0;
	")
	public function resetOffset() : Void {} ///makes offset 0 and offsetLength be length

	/// METHODS
	@:functionCode("
		_nativeData->writeData(data->_nativeData);
	")
	public function writeData(data : Data) : Void {}

	// Int write and read functions

	@:functionCode('
		staticWriteIntIntoPointer(_nativeData->ptr + _nativeData->offset, value, targetDataType);
	')
	public function writeInt(value : Int, targetDataType : DataType) : Void {}

	public function writeIntArray(array : Array<Int>, dataType : DataType) : Void
	{
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var prevOffset = get_offset();
		var currentOffset = prevOffset;
		for(i in 0...array.length)
		{
			set_offset(currentOffset);
			writeInt(array[i], dataType);

			currentOffset += dataSize;
		}
		set_offset(prevOffset);
	}

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		((int8_t*)pointer)[0] = (int8_t)value;
	')
	public function writeInt8(value : Int) : Void {}

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		((uint8_t*)pointer)[0] = (uint8_t)value;
	')
	public function writeUInt8(value : Int) : Void {}

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		((int16_t *)pointer)[0] = (int16_t)value;
	')
	public function writeInt16(value : Int) : Void {}

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		((uint16_t *)pointer)[0] = (uint16_t)value;
	')
	public function writeUInt16(value : Int) : Void {}

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		((int32_t *)pointer)[0] = (int32_t)value;
	')
	public function writeInt32(value : Int) : Void {}

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		((uint32_t *)pointer)[0] = (uint32_t)value;
	')
	public function writeUInt32(value : Int) : Void {}


	@:functionCode('
		return staticReadIntFromPointer(_nativeData->ptr + _nativeData->offset, targetDataType);
	')
	public function readInt(targetDataType : DataType) : Int { return 0; }

	public function readIntArray(count : Int, dataType : DataType) : Array<Int>
	{
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var prevOffset = get_offset();
		var currentOffset = prevOffset;

		var array = new Array<Int>();
		for(i in 0...count)
		{
			set_offset(currentOffset);
			array.push(readInt(dataType));

			currentOffset += dataSize;
		}
		set_offset(prevOffset);
		return array;
	}

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		return (int)(((int8_t*)pointer)[0]);
	')
	public function readInt8() : Int { return 0; }

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		return (int)(((uint8_t*)pointer)[0]);
	')
	public function readUInt8() : Int { return 0; }

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		return (int)(((int16_t*)pointer)[0]);
	')
	public function readInt16() : Int { return 0; }

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		return (int)(((uint16_t*)pointer)[0]);
	')
	public function readUInt16() : Int { return 0; }

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		return (int)(((int32_t*)pointer)[0]);
	')
	public function readInt32() : Int { return 0; }

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
		return (int)(((uint32_t*)pointer)[0]);
	')
	public function readUInt32() : Int { return 0; }

	// Float write and read functions

	@:functionCode('
		staticWriteFloatIntoPointer(_nativeData->ptr + _nativeData->offset, value, targetDataType);
	')
	public function writeFloat(value : Float, targetDataType : DataType) : Void {}

	public function writeFloatArray(array : Array<Float>, dataType : DataType) : Void
	{
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var prevOffset = get_offset();
		var currentOffset = prevOffset;
		for(i in 0...array.length)
		{
			set_offset(currentOffset);
			writeFloat(array[i], dataType);

			currentOffset += dataSize;
		}
		set_offset(prevOffset);
	}

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;
			#ifdef __arm__
			if ((((intptr_t)pointer) & 0x3) == 0)
			{
			#endif
				((float *)pointer)[0] = (float)value;
			#ifdef __arm__
			}
			else
			{
				float floatValue = (float)value;
				memcpy(pointer, &floatValue, sizeof(float));
			}
			#endif
	')
	public function writeFloat32(value : Float) : Void {}

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;

		#ifdef __arm__
			if ((((intptr_t)pointer) & 0x7) == 0)
			{
			#endif
				((double *)pointer)[0] = (double)value;
			#ifdef __arm__
			}
			else
			{
				memcpy(pointer, &value, sizeof(double));
			}
			#endif
	')
	public function writeFloat64(value : Float) : Void {}

	@:functionCode('
		return staticReadFloatFromPointer(_nativeData->ptr + _nativeData->offset, targetDataType);
	')
	public function readFloat(targetDataType : DataType) : Float { return 0; }

	public function readFloatArray(count : Int, dataType : DataType) : Array<Float>
	{
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var prevOffset = get_offset();
		var currentOffset = prevOffset;

		var array = new Array<Float>();
		for(i in 0...count)
		{
			set_offset(currentOffset);
			array.push(readFloat(dataType));

			currentOffset += dataSize;
		}
		set_offset(prevOffset);
		return array;
	}

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;

		#ifdef __arm__
			if ((((intptr_t)pointer) & 0x3) == 0)
			{
			#endif
				return ((float*)pointer)[0];
			#ifdef __arm__
			}
			else
			{
				float f;
				memcpy(&f, pointer, sizeof(float));
				return f;
			}
			#endif
	')
	public function readFloat32() : Float { return 0; }

	@:functionCode('
		void *pointer = _nativeData->ptr + _nativeData->offset;

			#ifdef __arm__
			if ((((intptr_t)pointer) & 0x7) == 0)
			{
			#endif
				return ((double*)pointer)[0];
			#ifdef __arm__
			}
			else
			{
				double d;
				memcpy(&d, pointer, sizeof(double));
				return d;
			}
			#endif
	')
	public function readFloat64() : Float { return 0; }

	@:functionCode('
		if (((dataType == null())))
			dataType = ::types::DataType_obj::DataTypeInt32;

		int dataSize = ::types::DataTypeUtils_obj::dataTypeByteSize(dataType);

		std::wostringstream oss;

		oss << "[";
		if(_nativeData->allocedLength >= 1)
		{
			oss << staticReadValueIntoString(_nativeData->ptr, dataType);
		}

		for(int i = 1; i < _nativeData->allocedLength / dataSize; i++)
		{
			oss << ", ";
			oss << staticReadValueIntoString(_nativeData->ptr + i * dataSize, dataType);
		}

		oss << "]";

		std::wstring str = oss.str();

		return ::String(str.c_str(), str.size() + 1);
	')
	public function toString(?dataType : DataType) : String { return "";}

	@:functionCode('
		_nativeData->resize(newSize);
	')
	public function resize(newSize : Int) : Void {}

	@:functionCode('
		_nativeData->trim();
	')
	public function trim() : Void {}

}
