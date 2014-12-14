package meman;

import buddy.Should;
import mockatoo.Mockatoo;
import buddy.BuddySuite;

import mockatoo.Mockatoo.*;
using mockatoo.Mockatoo;
using buddy.Should;

class ManagedSpecDummy {
    public function new() {}
}

class ManagedSpec extends BuddySuite {
    public function new() {
        describe('Managed object', function() {
            it('should point to an instance', function() {
                var obj = new ManagedSpecDummy();
                var mng = new Managed<ManagedSpecDummy>(obj);
                mng.obj.should.be(obj);
            });
        });
    }
}
