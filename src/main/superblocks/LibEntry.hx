package superblocks;

import meman.WeakRef;

class LibEntry<T> {

    var ref : WeakRef;
    var classType: Class<T>;

    public function new(cls:Class<T>) {
        ref = null;
        classType = cls;
    }

    public function get() : T {
        var inst : T;

        if (ref == null) {
            return this.instantiate();
        }

        return cast ref.get();
    }

    private function instantiate() : T {
        var inst = Type.createInstance(classType, []);
        ref = new WeakRef(cast inst);
        return inst;
    }
}
