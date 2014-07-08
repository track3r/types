package types;

class Vector2
{
    public var data(default, null) : Data;
    public var dataOffset(default, null) : Int;

    public function new(_data : Data = null, _dataOffset : Int = 0) : Void
    {
        if(_data == null)
        {
            data = new Data(4*4);
        }
        else
        {
            data = _data;
        }

        dataOffset = _dataOffset;
    }

/// Vector Interface

    public var x(get, set) : Float;
    public var y(get, set) : Float;

    public function get_x() : Float
    {
        data.offset = dataOffset + 0;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_x(x : Float) : Float
    {
        data.offset = dataOffset + 0;
        data.writeFloat(x, DataTypeFloat32);
        return x;
    }

    public function get_y() : Float
    {
        data.offset = dataOffset + 4;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_y(y : Float) : Float
    {
        data.offset = dataOffset + 4;
        data.writeFloat(y, DataTypeFloat32);
        return y;
    }

/// Color Interface

    public var s(get, set) : Float;
    public var t(get, set) : Float;


    public function get_s() : Float
    {
        data.offset = dataOffset + 0;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_s(s : Float) : Float
    {
        data.offset = dataOffset + 0;
        data.writeFloat(s, DataTypeFloat32);
        return s;
    }

    public function get_t() : Float
    {
        data.offset = dataOffset + 4;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_t(t : Float) : Float
    {
        data.offset = dataOffset + 4;
        data.writeFloat(t, DataTypeFloat32);
        return t;
    }

/// Setters & Getters

    public function setXY(_x : Float, _y)
    {
        x = _x;
        y = _y;
    }

    public function setST(_s : Float, _t : Float)
    {
        s = _s;
        t = _t;
    }

    public function set(other : Vector2) : Void
    {
        data.offset = dataOffset;
        other.data.offset = other.dataOffset;
        other.data.offsetLength = 2 * 4;
        data.writeData(other.data);
    }

    public function get(index : Int) : Float
    {
        data.offset = dataOffset + index * 4;
        return data.readFloat(DataTypeFloat32);
    }

/// Math

    public function negate() : Void
    {
        x = -x;
        y = -y;
    }

    public function add(right : Vector2) : Void
    {
        x = x + right.x;
        y = y + right.y;
    }

    public function subtract(right : Vector2) : Void
    {
        x = x - right.x;
        y = y - right.y;
    }

    public function multiply(right : Vector2) : Void
    {
        x = x * right.x;
        y = y * right.y;
    }

    public function divide(right : Vector2) : Void
    {
        x = x / right.x;
        y = y / right.y;
    }

    public function addScalar(value : Float) : Void
    {
        x = x + value;
        y = y + value;
    }

    public function subtractScalar(value : Float) : Void
    {
        x = x - value;
        y = y - value;
    }

    public function multiplyScalar(value : Float) : Void
    {
        x = x * value;
        y = y * value;
    }

    public function divideScalar(value : Float) : Void
    {
        x = x / value;
        y = y / value;
    }

    public function normalize() : Void
    {
        var scale:Float = 1.0 / Vector2.length(this);
        multiplyScalar(scale);
    }

    public function lerp(start : Vector2, end : Vector2, t : Float) : Void
    {
        x = start.x + ((end.x - start.x) * t);
        y = start.y + ((end.y - start.y) * t);
    }

    public static function length(vector : Vector2) : Float
    {
        return Math.sqrt(Vector2.lengthSquared(vector));
    }

    public static function lengthSquared(vector : Vector2) : Float
    {
        return vector.x * vector.x + vector.y * vector.y;
    }

    private static var distanceVector2:Vector2;
    public static function distance(start : Vector2, end : Vector2) : Float
    {
        if (distanceVector2 == null)
            distanceVector2 = new Vector2();

        distanceVector2.set(end);
        distanceVector2.subtract(start);

        return Vector2.length(distanceVector2);
    }

    public function toString() : String
    {
        var output = "";
        output += "[";

        data.offset = dataOffset;
        output += data.readFloat(DataTypeFloat32);

        for(i in 1...2)
        {
            output += ", ";
            data.offset += 4;
            output += data.readFloat(DataTypeFloat32);
        }

        output += "]";
        return output;
    }

}
