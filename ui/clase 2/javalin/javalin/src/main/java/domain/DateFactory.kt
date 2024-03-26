package domain

import java.text.DateFormat
import java.text.SimpleDateFormat
import java.time.Instant
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.*
import javax.swing.text.DateFormatter

class DateFactory {
    companion object {
        private val dateFormatTemplate = "dd/MM/yyyy"

        fun isValidDateFromString(date: String): Boolean {
            try {
                val formatter = DateTimeFormatter.ofPattern(dateFormatTemplate)
                LocalDate.parse(dateFormatTemplate, formatter)
                return true
            } catch (_: Throwable) {
                return false
            }
        }

        fun dateFromString(date: String): LocalDate {
            val formatter = DateTimeFormatter.ofPattern(dateFormatTemplate)
            return LocalDate.parse(date).apply {
                format(formatter)
            }
        }

        fun currentTime(): LocalDate {
            val formatter = DateTimeFormatter.ofPattern(dateFormatTemplate)
            return LocalDate.now().apply {
                format(formatter)
            }
        }
    }
}
