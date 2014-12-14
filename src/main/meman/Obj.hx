package meman;

class Obj implements IObj {

    public var objectId(get,set):Int;
    public var refCount(get, set):Int;

    var _objectId:Int;
    var _refCount:Int;

    public function new(?inst:IMeman) {
        if (inst == null) {
            Meman.inst.initialize(this);
        } else {
            inst.initialize(this);
        }

    }

    public function get_objectId():Int {
        return _objectId;
    }

    public function set_objectId(id:Int):Int {
        _objectId = id;
        return id;
    }

    public function get_refCount():Int {
        return _refCount;
    }

    public function set_refCount(count:Int):Int {
        _refCount = count;
        return count;
    }
}
