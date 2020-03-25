package test.io;

import haxe.io.Bytes;
import hxdf.io.BytesTools;

class BytesToolsTests extends hxtf.TestObject {
    public function new() {
        test_stringifying();
        test_parsing();
        test_juggling();
    }

    function test_stringifying():Void {
        var bytes = Bytes.alloc(4);

        bytes.setInt32(0, 19);
        assert(BytesTools.stringifyLittleEndian(bytes) == "11001000000000000000000000000000");
        assert(BytesTools.stringifyLittleEndian(bytes, true) == "11001");
        assert(BytesTools.stringifyBigEndian(bytes) == "00000000000000000000000000010011");
        assert(BytesTools.stringifyBigEndian(bytes, true) == "10011");

        bytes.setInt32(0, -43982734);
        assert(BytesTools.stringifyLittleEndian(bytes) == "01001110000001110000011010111111");
        assert(BytesTools.stringifyLittleEndian(bytes, true) == "01001110000001110000011010111111");
        assert(BytesTools.stringifyBigEndian(bytes) == "11111101011000001110000001110010");
        assert(BytesTools.stringifyBigEndian(bytes, true) == "11111101011000001110000001110010");

        bytes = Bytes.alloc(1);

        bytes.set(0, 1);
        assert(BytesTools.stringifyLittleEndian(bytes) == "10000000");
        assert(BytesTools.stringifyLittleEndian(bytes, true) == "1");
        assert(BytesTools.stringifyBigEndian(bytes) == "00000001");
        assert(BytesTools.stringifyBigEndian(bytes, true) == "1");

        bytes.set(0, 130);
        assert(BytesTools.stringifyLittleEndian(bytes) == "01000001");
        assert(BytesTools.stringifyLittleEndian(bytes, true) == "01000001");
        assert(BytesTools.stringifyBigEndian(bytes) == "10000010");
        assert(BytesTools.stringifyBigEndian(bytes, true) == "10000010");
    }

    function test_parsing():Void {
        var bytes = Bytes.alloc(4);

        bytes.setInt32(0, 19);
        assert(bytes.compare(BytesTools.parseLittleEndian("11001000000000000000000000000000")) == 0);
        assert(BytesTools.parseLittleEndian("11001").get(0) == 19);
        assert(bytes.compare(BytesTools.parseBigEndian("00000000000000000000000000010011")) == 0);
        assert(BytesTools.parseBigEndian("10011").get(0) == 19);

        bytes.setInt32(0, -43982734);
        assert(bytes.compare(BytesTools.parseLittleEndian("01001110000001110000011010111111")) == 0);
        assert(bytes.compare(BytesTools.parseBigEndian("11111101011000001110000001110010")) == 0);

        bytes = Bytes.alloc(1);

        bytes.set(0, 1);
        assert(bytes.compare(BytesTools.parseLittleEndian("10000000")) == 0);
        assert(bytes.compare(BytesTools.parseLittleEndian("1")) == 0);
        assert(bytes.compare(BytesTools.parseBigEndian("00000001")) == 0);
        assert(bytes.compare(BytesTools.parseBigEndian("1")) == 0);

        bytes.set(0, 130);
        assert(bytes.compare(BytesTools.parseLittleEndian("01000001")) == 0);
        assert(bytes.compare(BytesTools.parseBigEndian("10000010")) == 0);
    }

    function test_juggling():Void {
        assert(BytesTools.stringifyLittleEndian(BytesTools.parseLittleEndian("1011")) == "10110000");
        assert(BytesTools.stringifyLittleEndian(BytesTools.parseBigEndian("1011")) == "11010000");
        assert(BytesTools.stringifyBigEndian(BytesTools.parseLittleEndian("1011")) == "00001101");
        assert(BytesTools.stringifyBigEndian(BytesTools.parseBigEndian("1011")) == "00001011");
        assert(BytesTools.stringifyLittleEndian(BytesTools.parseLittleEndian("1011"), true) == "1011");
        assert(BytesTools.stringifyLittleEndian(BytesTools.parseBigEndian("1011"), true) == "1101");
        assert(BytesTools.stringifyBigEndian(BytesTools.parseLittleEndian("1011"), true) == "1101");
        assert(BytesTools.stringifyBigEndian(BytesTools.parseBigEndian("1011"), true) == "1011");

        var bytes = Bytes.alloc(1);
        bytes.set(0, 91);
        assert(bytes.compare(BytesTools.parseLittleEndian(BytesTools.stringifyLittleEndian(bytes))) == 0);
        assert(bytes.compare(BytesTools.parseLittleEndian(BytesTools.stringifyLittleEndian(bytes, true))) == 0);
        assert(bytes.compare(BytesTools.parseBigEndian(BytesTools.stringifyBigEndian(bytes))) == 0);
        assert(bytes.compare(BytesTools.parseBigEndian(BytesTools.stringifyBigEndian(bytes, true))) == 0);

        var bytesMirrored = Bytes.alloc(1);
        bytesMirrored.set(0, -38);
        assert(bytes.compare(BytesTools.parseLittleEndian(BytesTools.stringifyBigEndian(bytesMirrored))) == 0);
        assert(bytes.compare(BytesTools.parseLittleEndian(BytesTools.stringifyBigEndian(bytesMirrored, true))) == 0);
        assert(bytes.compare(BytesTools.parseBigEndian(BytesTools.stringifyLittleEndian(bytesMirrored))) == 0);
        assert(bytes.compare(BytesTools.parseBigEndian(BytesTools.stringifyLittleEndian(bytesMirrored, true))) == 0);
    }
}
