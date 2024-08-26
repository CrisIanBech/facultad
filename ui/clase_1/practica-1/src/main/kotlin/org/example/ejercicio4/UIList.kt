package org.example.ejercicio4

class UIList {
    fun isSorted(elements: List<Int>): Boolean {
        if (elements.size < 2) return true
        val predicate: (first: Int, second: Int) -> Boolean
        if (elements[0] > elements[1]) {
            predicate = { first, second -> first > second }
        } else {
            predicate = { first, second -> first < second }
        }
        for (index in 1 until elements.size) {
            if (!predicate(elements[0], elements[1])) return false
        }
        return true
    }

    fun ordered(elements: List<Int>, asc: Boolean): List<Int> {
        if (elements.size < 2) return elements
        val middle: Int = elements.size / 2

        val comparates: (first: Int, second: Int) -> Boolean = if (!asc) { {first, second -> first > second } } else {
            {first, second -> second > first }
        }

        val left = ordered(elements.subList(0, middle), asc).toMutableList()
        val right = ordered(elements.subList(middle, elements.size), asc).toMutableList()
        val orderedElements = mutableListOf<Int>()
        while (left.isNotEmpty() && right.isNotEmpty()) {
            if(comparates(left.first(), right.first())) {
                orderedElements.add(left.removeFirst())
            } else {
                orderedElements.add(right.removeFirst())
            }
        }
        if (left.isEmpty()) orderedElements.addAll(right)
        if (right.isEmpty()) orderedElements.addAll(left)

        return orderedElements
    }

    fun filterPrimes(numbers: List<Int>) = numbers.filter(::isPrime)

    fun isPrime(number: Int): Boolean {
        if (number == 1 || number == 0) return false
        (2 until number).forEach {
            if (number % it == 0) return false
        }
        return true
    }

    fun powMap(numbers: List<Int>) = numbers.map { it * it }

    fun sumProdPos(numbers: List<Int>): Int = numbers.reduceIndexed { index: Int, accum: Int, current: Int ->
        accum + current * (index + 1)
    }
}