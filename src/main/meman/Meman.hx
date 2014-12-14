package meman;

class Meman implements IMeman {

    public static var inst(get, set) : IMeman;

    static var _inst : IMeman;

    public static function set_inst(i:IMeman) : IMeman {
        _inst = i;
        return _inst;
    }

    public static function get_inst() : IMeman {
        if (_inst == null) {
            _inst = new Meman();
        }
        return _inst;
    }

    var instances : Array<IObj>;

    public function new() {
        instances = new Array<IObj>();
    }

    public function initialize(obj:IObj):IObj {
        instances.push(null);
        obj.set_objectId(instances.length);
        obj.set_refCount(0);
        return obj;
    }

    public function add(obj:IObj):IObj {
        if (obj.get_refCount() == 0) {
            instances[obj.get_objectId() - 1] = obj;
        }
        obj.set_refCount(obj.get_refCount() + 1);

        return obj;
    }

    public function remove(obj:IObj):IObj {
        var count = obj.set_refCount(obj.get_refCount() - 1);
        if (count <= 0) {
            instances[obj.get_objectId() - 1] = null;
        }
        return obj;
    }

    public function get(objectId:Int):IObj {
        return instances[objectId - 1];
    }
}
