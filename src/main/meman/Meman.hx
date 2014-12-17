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

    var heap : Array<IObj>;

    public function new() {
        heap = new Array<IObj>();
    }

    /**
    * Assigns an ID to the object and sets refcount to 0
    **/
    public function initialize(obj:IObj):IObj {
        heap.push(null);
        obj.set_objectId(heap.length);
        obj.set_refCount(0);
        return obj;
    }

    /**
    * Increments the refcount of the object
    **/
    public function add(obj:IObj):IObj {
        if (obj == null) return null;
        if (obj.get_refCount() == 0) {
            heap[obj.get_objectId() - 1] = obj;
        }
        obj.set_refCount(obj.get_refCount() + 1);

        return obj;
    }

    /**
    * Decrements the refcount of the object
    **/
    public function remove(obj:IObj):IObj {
        if (obj == null) {
            return null;
        }
        var count = obj.set_refCount(obj.get_refCount() - 1);
        if (count <= 0) {
            heap[obj.get_objectId() - 1] = null;
            obj.collect();
        }
        return obj;
    }

    /**
    * Called when changing the attribute of an object instance
    **/
    public function changeAttribute(obj:IObj, oldVal: IObj, newVal: IObj) {
        if (oldVal != obj) {
            remove(oldVal);
        }
        if (newVal != obj) {
            add(newVal);
        }
        return newVal;
    }

    /**
    * Retrieves an object instance from an object id
    **/
    public function get(objectId:Int):IObj {
        return heap[objectId - 1];
    }
}
