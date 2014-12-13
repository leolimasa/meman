package meman;

class Meman implements IMeman {

    var instances : Array<IManaged>;

    public function new() {
        instances = new Array<IManaged>();
    }

    public function add(obj:IManaged):IManaged {
        obj.set_refCount(obj.get_refCount() + 1);
        if (obj.get_objectId() == 0) {
            instances.push(obj);
            obj.set_objectId(instances.length);
        }
        return obj;
    }

    public function remove(obj:IManaged):IManaged {
        var count = obj.set_refCount(obj.get_refCount() - 1);
        if (count <= 0) {
            instances[obj.get_objectId() - 1] = null;
        }
        return obj;
    }

    public function get(objectId:Int):IManaged {
        return instances[objectId - 1];
    }
}
