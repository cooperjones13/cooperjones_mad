package com.example.cooperjones.quickstep;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    private Integer timerLength = 0; //timer length in milliseconds
    private Integer numSteps = 0; //number of steps

    private EditText edit_minutes;
    private EditText edit_seconds;
    private EditText edit_steps;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        edit_minutes = findViewById(R.id.edit_minutes);
        edit_seconds = findViewById(R.id.edit_seconds);
        edit_steps = findViewById(R.id.edit_steps);
    }

//    public void startTimer(View view){
//        submit = findViewById(R.id.start_timer);
//        submit.setVisibility(View.INVISIBLE);
//
//        CountDownTimer timer = new CountDownTimer(timerLength, 1000) {
//            @Override
//            public void onTick(long millisUntilFinished) {
//                timerDisplay.setText(millisUntilFinished/60000 + "m " + (millisUntilFinished%60000)/1000 + "s");
//            }
//
//            @Override
//            public void onFinish() {
//                timerDisplay.setText("Done");
//                submit.setVisibility(View.VISIBLE);
//            }
//        }.start();
//    }

    public void startTimerView(View view){

        numSteps = 0;
        timerLength = 0;

        if(edit_minutes.getText().toString().isEmpty()){
            edit_minutes.setText("00");
        }
        timerLength += 1000*60*Integer.parseInt(edit_minutes.getText().toString());

        if(edit_seconds.getText().toString().isEmpty()){
            edit_seconds.setText("00");
        }
        timerLength += 1000*Integer.parseInt(edit_seconds.getText().toString());

        if(edit_steps.getText().toString().isEmpty()){
            edit_steps.setText("000");
        }
        numSteps += Integer.parseInt(edit_steps.getText().toString());

        Intent intent = new Intent(this, runTimer.class);
        intent.putExtra("time", timerLength);
        intent.putExtra("steps", numSteps);
        startActivity(intent);

    }

}
