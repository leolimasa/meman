package meman;

class Managed implements IManaged {
    public var objectId(get,set):Int;
    public var refCount(get, set):Int;

    var _objectId:Int;
    var _refCount:Int;

    public function new() {
        objectId = 0;
        refCount = 0;
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
