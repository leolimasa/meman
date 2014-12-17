package meman;

import meman.mock.MockObj;
import buddy.Should;
import mockatoo.Mockatoo;
import buddy.BuddySuite;

import mockatoo.Mockatoo.*;
using mockatoo.Mockatoo;
using buddy.Should;

class WeakRefSpec extends BuddySuite {
    public function new() {
        describe('Weak reference', function() {
            it('is able to store and retrieve an object', function() {
                var ref = new WeakRef();
                var obj = new MockObj();

                Meman.inst.add(obj);

                ref.set(obj);
                obj.refCount.should.be(1);
                ref.get().should.be(obj);

                Meman.inst.remove(obj);
            });
        });
    }
}
