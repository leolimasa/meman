package meman;

#if coverage
import mcover.coverage.MCoverage;
#end

import meman.MemanSpec;
import buddy.reporting.ConsoleReporter;
import buddy.SuitesRunner;

class TestMain {
    public static function main() {

        var reporter = new ConsoleReporter();
        var runner = new SuitesRunner([
            new MemanSpec()
        ], reporter);


        runner.run();

        #if coverage
        var coverage_logger = MCoverage.getLogger();
        coverage_logger.report();
        #end

        return runner.statusCode();
    }
}