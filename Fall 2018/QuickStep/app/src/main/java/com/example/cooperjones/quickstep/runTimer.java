package com.example.cooperjones.quickstep;

import android.content.Context;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.CountDownTimer;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

public class runTimer extends AppCompatActivity {

    TextView display_time;
    TextView display_steps;

    Integer time;
    Integer curr_steps = 0;
    Integer goal_steps;

    ProgressBar progressBar;

    private SensorManager sensorManager;
    private Sensor stepSensor;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_run_timer);

        display_steps = findViewById(R.id.display_steps);
        display_time = findViewById(R.id.display_time);

        progressBar = findViewById(R.id.progressBar);
        //progressBar.setMax(goal_steps);

        Intent intent = getIntent();

        goal_steps = intent.getIntExtra("steps", 100);
        time = intent.getIntExtra("time", 0);
        updateSteps();
//
        startTimer();
    }


    public void startTimer(){
//        sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
//        stepSensor = sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER);
//
//        Context context = getApplicationContext();
//        CharSequence text = getString(R.string.step_count_error);
//        int duration = Toast.LENGTH_LONG;
//
//        Toast toast = Toast.makeText(context, text, duration);
//        toast.show();



        CountDownTimer timer = new CountDownTimer(time, 1000) {



            @Override
            public void onTick(long millisUntilFinished) {
                display_time.setText(millisUntilFinished/60000 + ":" + (millisUntilFinished%60000)/1000);
                updateSteps();
            }

            @Override
            public void onFinish() {
                display_time.setText("Done");
            }
        }.start();
    }

    public void updateSteps(){
        //update current step
        curr_steps+= 3;
        //display
        display_steps.setText(curr_steps.toString()+"/"+goal_steps.toString());
        if(curr_steps >= goal_steps){
            progressBar.setProgress(100);
        }
        else{
            progressBar.setProgress((int)((float)curr_steps/(float)goal_steps*100));
        }

        Log.d("steps", "steps updated");
    }

    public final void onSensorChanged(SensorEvent event){
        curr_steps = (int)event.values[0];
    }

}
