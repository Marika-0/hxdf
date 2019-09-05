package;

class TestMain extends TestBroker {
    public function new() {
        printName();
    }

    function printName():Void {
        if (haxe.macro.Compiler.getDefine("test_name") != null) {
            hxtf.Print.stdout('[45;1m${haxe.macro.Compiler.getDefine("test_name")}[0m\n');
        }
    }
}
