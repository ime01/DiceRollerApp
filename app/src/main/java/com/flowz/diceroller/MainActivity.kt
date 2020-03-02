package com.flowz.diceroller

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import kotlinx.android.synthetic.main.activity_main.*
import kotlin.random.Random


class MainActivity : AppCompatActivity() {

    lateinit var dicePic : ImageView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        dicePic = findViewById(R.id.dice_image)

        roll_dice.setOnClickListener {
            RollDice()
        }
    }

    private fun RollDice() {

      val randomNumber = java.util.Random().nextInt(6)+1

      val selectImageResource =  when(randomNumber){

          1-> R.drawable.dice_1
          2-> R.drawable.dice_2
          3-> R.drawable.dice_3
          4-> R.drawable.dice_4
          5-> R.drawable.dice_5
          else -> R.drawable.dice_6
      }

        dicePic.setImageResource(selectImageResource)

    }
}
