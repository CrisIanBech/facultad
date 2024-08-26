fun <T: Comparable<T>> mergeSort(mutableList: MutableList<T>): MutableList<T> {
    if (mutableList.size <= 1) return mutableList
    val middle: Int = mutableList.size / 2
    var left = mutableList.subList(0, middle)
    var right = mutableList.subList(middle, mutableList.size)
    left = mergeSort(left)
    right = mergeSort(right)
    if(left.last() <= right.first()) return (left + right).toMutableList()
    return merge(left, right)
}

fun <T: Comparable<T>> merge(left: MutableList<T>, right: MutableList<T>): MutableList<T> {
    val result = mutableListOf<T>()
    while (left.isNotEmpty() && right.isNotEmpty()) {
        if(left.first() <= right.first()) {
            result.add(left.first())
            left.removeFirst()
        } else {
            result.add(right.first())
            right.removeFirst()
        }
    }
    if(left.isEmpty()) result.addAll(right)
    if(right.isEmpty()) result.addAll(left)
    return result
}
