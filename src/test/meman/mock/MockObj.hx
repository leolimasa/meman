package meman.mock;

import meman.IMeman;
import meman.Obj;
import meman.IObj;

class MockObj extends Obj {

    public var child1(get, set):IObj;
    public var child2(get, set):IObj;

    var _child1:IObj;
    var _child2:IObj;

    public function set_child1(value:IObj) {
        Meman.inst.changeAttribute(this, this._child1, value);
        return this._child1 = value;
    }

    public function get_child1():IObj {
        return _child1;
    }

    public function set_child2(value:IObj) {
        Meman.inst.changeAttribute(this, this._child2, value);
        return this._child2 = value;
    }

    public function get_child2():IObj {
        return _child2;
    }

    public override function collect() {
        child1 = null;
        child2 = null;
    }

    public function new(?manager:IMeman) {
        super(manager);
    }
}
