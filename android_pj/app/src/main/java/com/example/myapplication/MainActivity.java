package com.example.myapplication;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;

import com.google.android.material.bottomnavigation.BottomNavigationView;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterFragment;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;

public class MainActivity extends AppCompatActivity {
    static final String FLUTTER_ENGINE_ID = "FLUTTER_ENGINE_ID";
    private static final String TAG_FLUTTER_FRAGMENT = "flutter_fragment";
    private FlutterFragment flutterFragment;
    FlutterEngine flutterEngine;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        configFlutterView(this);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        BottomNavigationView bottomNavigationView = findViewById(R.id.bottom_nav);
        bottomNavigationView.setOnNavigationItemSelectedListener(navListener);
        getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,new HomeFragment()).commit();
    }

    private BottomNavigationView.OnNavigationItemSelectedListener navListener = new BottomNavigationView.OnNavigationItemSelectedListener(){
        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item){
            Fragment selFragment = null;
             switch (item.getItemId()){
                 case R.id.nav_home:
                     selFragment = new HomeFragment();
                     getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,selFragment).commit();
                     break;
                 case R.id.nav_person:
//                     selFragment = new PersonFragment();
//                     getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,selFragment).commit();

                     FragmentManager fragmentManager = getSupportFragmentManager();
                     flutterFragment = (FlutterFragment) fragmentManager
                             .findFragmentByTag(TAG_FLUTTER_FRAGMENT);
                     if (flutterFragment == null) {
                         flutterFragment = FlutterFragment.withCachedEngine(FLUTTER_ENGINE_ID).build();

                         fragmentManager
                                 .beginTransaction()
                                 .replace(
                                         R.id.fragment_container,
                                         flutterFragment,
                                         TAG_FLUTTER_FRAGMENT
                                 )
                                 .commit();
                     }
                     break;
                 case R.id.nav_setting:
                     selFragment = new SettingFragment();
                     getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,selFragment).commit();
                     break;
             }
             return true;
        }
    };

    private void configFlutterView(Context context) {

        if (FlutterEngineCache.getInstance().get(FLUTTER_ENGINE_ID) != null) {
            flutterEngine = FlutterEngineCache.getInstance().get(FLUTTER_ENGINE_ID);
        } else {
            flutterEngine = new FlutterEngine(context);
            flutterEngine.getDartExecutor().executeDartEntrypoint(
                    DartExecutor.DartEntrypoint.createDefault()
            );
            FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_ID, flutterEngine);
        }
    }
}