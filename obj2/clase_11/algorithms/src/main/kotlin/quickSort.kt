fun <T : Comparable<T>> quickSort(mutableList: MutableList<T>): MutableList<T> {
    if (mutableList.size == 2) return if (mutableList.first() <= mutableList[1]) mutableListOf(
        mutableList.first(),
        mutableList[1]
    ) else mutableListOf(mutableList[1], mutableList.first())
    else if(mutableList.size <= 1) return mutableList

    val middle: Int = mutableList.size / 2
    val middleElement = mutableList[middle]
    var smallers = mutableListOf<T>()
    var biggers = mutableListOf<T>()
    (0 until mutableList.size).forEach {
        if (it != middle) {
            val element = mutableList[it]
            if (element <= middleElement) smallers.add(element) else biggers.add(element)
        }
    }
    smallers = quickSort(smallers)
    biggers = quickSort(biggers)

    val result = (smallers + middleElement).toMutableList()
    result += biggers

    return result
}