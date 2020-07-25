package hxdf.io;

import haxe.io.Bytes;

using StringTools;

/**
    Utility functions for working with the `haxe.io.Bytes` class.
**/
class BytesTools {
    static final BYTE_POWER_TABLE = [128, 64, 32, 16, 8, 4, 2, 1];

    /**
        Alias for `stringifyLittleEndian`.
    **/
    public static inline function stringify(b:Bytes, trim = false):String {
        return stringifyLittleEndian(b, trim);
    }

    /**
        Produces a String representation of the given bytes `b`.

        The returned String is formatted in little-endian.

        If `trim` is `true`, the returned String is trimmed of trailing zeroes
        (from the right).
    **/
    public static function stringifyLittleEndian(b:Bytes, trim = false):String {
        inline function flushZeroes(buf:StringBuf, amount:UInt):Void {
            while (amount != 0) {
                buf.addChar("0".code);
                amount--;
            }
        }

        var buf = new StringBuf();
        var zeroCount:UInt = 0;
        for (i in 0...b.length) {
            var byte = b.get(i);
            for (j in 0...8) {
                if (byte & (1 << j) == 0) {
                    zeroCount++;
                } else {
                    flushZeroes(buf, zeroCount);
                    zeroCount = 0;
                    buf.addChar("1".code);
                }
            }
        }
        if (!trim) {
            flushZeroes(buf, zeroCount);
        }
        return buf.toString();
    }

    /**
        Produces a String representation of the given bytes `b`.

        The returned String is formatted in big-endian.

        If `trim` is `true`, the returned String is trimmed of trailing zeroes
        (from the left).
    **/
    public static function stringifyBigEndian(b:Bytes, trim = false):String {
        var buf = new StringBuf();
        for (i in 0...b.length) {
            var byte = b.get(b.length - i - 1);
            for (j in 0...8) {
                if (byte & (1 << (7 - j)) == 0) {
                    if (!trim) {
                        buf.addChar("0".code);
                    }
                } else {
                    buf.addChar("1".code);
                    trim = false;
                }
            }
        }
        return buf.toString();
    }

    /**
        Alias for `parseLittleEndian`.
    **/
    public static inline function parse(str:String):Bytes {
        return parseLittleEndian(str);
    }

    /**
        Parses the given String as little-endian into its corresponding Bytes.

        If the String contains any characters other than `"0"` and `"1"`, the
        result is undefined.
    **/
    public static function parseLittleEndian(str:String):Bytes {
        var byteCount = Std.int(str.length / 8);
        if (byteCount * 8 != str.length) {
            byteCount++;
            str = str.rpad("0", byteCount * 8);
        }

        var bytes = Bytes.alloc(byteCount);
        for (i in 0...bytes.length) {
            var byte = 0;
            for (j in 0...8) {
                if (str.fastCodeAt(i * 8 + j) == "1".code) {
                    byte += BYTE_POWER_TABLE[7 - j];
                }
            }
            bytes.set(i, byte);
        }
        return bytes;
    }

    /**
        Parses the given String as big-endian into its corresponding Bytes.

        If the String contains any characters other than `"0"` and `"1"`, the
        result is undefined.
    **/
    public static function parseBigEndian(str:String):Bytes {
        var byteCount = Std.int(str.length / 8);
        if (byteCount * 8 != str.length) {
            byteCount++;
            str = str.lpad("0", byteCount * 8);
        }

        var bytes = Bytes.alloc(byteCount);
        for (i in 0...bytes.length) {
            var byte = 0;
            for (j in 0...8) {
                if (str.fastCodeAt(i * 8 + j) == "1".code) {
                    byte += BYTE_POWER_TABLE[j];
                }
            }
            bytes.set(bytes.length - i - 1, byte);
        }
        return bytes;
    }
}
