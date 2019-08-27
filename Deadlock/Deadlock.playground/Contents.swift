
import UIKit

let deadlockQueue = DispatchQueue(label: "indegene")
deadlockQueue.async {
    print("start")
    deadlockQueue.sync {
        print("deadlock")
        /*  The code inside this closure should also be executed synchronously and
            still executing the outer closure, it will keep waiting
            for it to finish - it will never be executed ==> Deadlock.
        */
    }
    print("finish") // this will never be excuted
}


