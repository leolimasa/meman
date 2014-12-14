package meman;

class Managed<T> extends Obj {

    public var obj:T;

    public function new(instance:T) {
        super();
        obj = instance;
    }
}
