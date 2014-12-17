package superblocks;

import meman.mock.MockObj;
import meman.Meman;
import meman.Obj;
import buddy.Should;
import mockatoo.Mockatoo;
import buddy.BuddySuite;

import mockatoo.Mockatoo.*;
using mockatoo.Mockatoo;
using buddy.Should;

class LibEntrySpec extends BuddySuite {
    public function new() {
        describe('Library entry', function() {
            var entry : LibEntry<MockObj>;

            before(function() {
                entry = new LibEntry<MockObj>(MockObj);
            });

            it('retrieves a typed object', function() {
                var entr = entry.get();
                entr.should.not.be(null);
            });

            it('retrieves the same instance even after the first retrieval', function() {
                var inst1 = entry.get();

                Meman.inst.add(inst1);

                var inst2 = entry.get();
                inst1.should.be(inst2);

                Meman.inst.remove(inst1);
            });

            it('does not increment the ref count', function() {
                var inst1 = entry.get();
                Meman.inst.add(inst1);
                entry.get().get_refCount().should.be(1);
                Meman.inst.remove(inst1);
            });
        });
    }
}
