import kotlinx.coroutines.FlowPreview
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.runBlocking

@OptIn(FlowPreview::class)
fun main() = runBlocking {
    val flowA = (1..3).asFlow()
    val flowB = flowA.map { it * 2 }
    val flowC = flowA.flatMapConcat {

    }

//    val concatenatedFlow = flowA.flatMapConcat { valueA ->
//        flowB.map { valueB ->
//            valueA + valueB
//        }
//    }

//    concatenatedFlow.collect { println(it) }
}
