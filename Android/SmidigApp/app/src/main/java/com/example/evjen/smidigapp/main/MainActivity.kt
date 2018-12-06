package com.example.evjen.smidigapp.main

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import androidx.navigation.Navigation
import com.example.evjen.smidigapp.R

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // navController = Navigation.findNavController(this, R.id.navHostFragment_main)

    }
}
