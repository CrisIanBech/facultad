package org.example.ejercicio2

class Str {
    fun revert(string: String): String {
        val finalString = StringBuilder()
        for(letterIndex in string.indices.last downTo  0) {
            finalString.append(string[letterIndex])
        }
        return finalString.toString()
    }

    fun esCapicua(string: String): Boolean {
        var index = 0
        val mid: Int = string.lastIndex / 2
        while (index < mid) {
            if(string[index] != string[string.lastIndex - index]) return false
            index++
        }
        return true
    }

    fun vowels(string: String) = string.count(::isVowel)

    private fun isVowel(char: Char): Boolean {
        return char == 'a' || char == 'e' || char == 'i' || char == 'o' || char == 'u'
    }

    fun words(string: String): Int = occurrencesWithCharSeparatorAndLastLetter(string, ' ')

    fun paragraphs(string: String): Int = occurrencesWithCharSeparatorAndLastLetter(string, '\n')

    fun occurrencesWithCharSeparatorAndLastLetter(string: String, occurrence: Char): Int {
        val stringWithAppendedOccurrence = string + occurrence
        var countedWords: Int = 0
        var lastCharHadLetter = false
        for (letterIndex in stringWithAppendedOccurrence.indices) {
            val currentLetter = stringWithAppendedOccurrence[letterIndex]
            if(currentLetter == occurrence && lastCharHadLetter) {
                countedWords++
                lastCharHadLetter = false
            } else {
                lastCharHadLetter = true
            }
        }
        return countedWords
    }
}