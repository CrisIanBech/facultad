package org.example.ejercicio2

import junit.framework.TestCase
import junit.framework.TestCase.assertEquals
import junit.framework.TestCase.assertFalse
import org.junit.Test

class StrTest {

    val str = Str()

    @Test
    fun testRevertsWorksForInterfaces() {
        val interfaces = "interfaces"
        val secafretni = "secafretni"
        assertEquals(str.revert(interfaces), secafretni)
    }

    @Test
    fun revertsWorksForEmptyCase() {
        assertEquals(str.revert(""), "")
    }

    @Test
    fun interfacesIsPalindromeIsFalse() {
        val interfaces = "interfaces"
        assertFalse(str.esCapicua(interfaces))
    }

    @Test
    fun neuquenIsPalindromeIsTrue() {
        val neuquen = "neuquen"
        assert(str.esCapicua(neuquen))
    }

    @Test
    fun emptyIsPalindrome() {
        val empty = ""
        assert(str.esCapicua(empty))
    }

    @Test
    fun fiveVowels() {
        val stringWithFiveVowels = "como vas a ir"
        assertEquals(str.vowels(stringWithFiveVowels), 5)
    }

    @Test
    fun zeroVowels() {
        val stringWithoutVowels = "lklvm gfklh"
        assertEquals(str.vowels(stringWithoutVowels), 0)
    }

    @Test
    fun zeroWords() {
        val stringWithoutWords = ""
        assertEquals(str.words(stringWithoutWords), 0)
    }

    @Test
    fun twentyFourWords() {
        assertEquals(str.words(shortText()), 24)
    }

    @Test
    fun zeroParagraphs() {
        val stringWithoutParagraphs = ""
        assertEquals(str.paragraphs(stringWithoutParagraphs), 0)
    }

    @Test
    fun threeParagraphs() {
        assertEquals(str.paragraphs(longText()), 3)
    }

    private fun longText() = """
        La mañana despierta, el sol brilla. Las calles vacías, el silencio reina. Un café caliente, aroma que invita. El primer paso, la aventura inicia.
        Los edificios altos, imponentes se elevan. Las personas corren, sus vidas aceleran. El parque central, un oasis verde. Los niños juegan, la risa se expande.
        El museo de historia, secretos guarda. Las obras de arte, belleza irradian. La biblioteca, un refugio de paz. Los libros esperan, historias por contar.
        """.trimIndent()

    private fun shortText() = "La mañana despierta, el sol brilla. Las calles vacías, el silencio reina. Un café caliente, aroma que invita. El primer paso, la aventura inicia. "

}