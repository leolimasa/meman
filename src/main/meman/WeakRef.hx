package meman;

class WeakRef implements IWeakRef {

    var id : Int;

    public function new(?inst:IObj) {
        if (inst != null) {
            id = inst.get_objectId();
        }
    }

    public function get():IObj {
        return Meman.inst.get(id);
    }

    public function set(obj:IObj):IObj {
        id = obj.get_objectId();
        return obj;
    }

}
