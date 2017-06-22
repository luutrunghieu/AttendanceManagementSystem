<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;
use GuzzleHttp\Client;
use Illuminate\Support\Facades\Session;

class PagesController extends Controller
{
    //
    public function index(){
        $classes = DB::table('class')->where('id','IT4091')->get();
        $profs = DB::table('professor')->where('id','100001')->get();
        $lectures = DB::table('lecture')->where('class_id','IT4091')->get();
        $students = DB::table('student')->get();
        foreach($students as $student){
            $attlist = DB::table('attendancelist')->select('lecture_id')->where([['class_id','IT4091'],['student_id',$student->id]])->get();
            $student->attlist = $attlist;
        }
        return view('class.show')->with(['classes'=>$classes,'profs'=>$profs,'lectures'=>$lectures,'students'=>$students]);
    }

    public function update(){
        $file = Input::file('photo');
        if($file){
            $lecture_id = Input::get('lecturelist');
            $fileName = $file->getClientOriginalName();
            $destinationPath = 'uploads/IT4091/'.$lecture_id;
            $file->move($destinationPath,$fileName);
            // DB::table('lectureimage')->insert(
            //     ['link'=>$destinationPath.'/'.$fileName,'lecture_id'=>$lecture_id]
            // );
            // $image_id = DB::table('lectureimage')->select('id')->where('link',$destinationPath.'/'.$fileName)->get();
            // $image_id = $image_id[0]->id;
            $static_link = "https://9d4b6cec.ngrok.io";
            $client = new Client(['base_uri' => $static_link]);
            $response = $client->request('POST', $static_link.'/upload', [
                'multipart' => [
                    [
                        'name'     => 'photo',
                        'contents' => fopen($destinationPath.'/'.$fileName, 'r')
                    ]
                ]
            ]);
            // dd($response);
            // $client = new Client(['base_uri' => 'http://localhost:8080/']);
            // $response = $client->request('GET', '/getJSON');
            $body = $response->getBody();
            $decoded = json_decode($body);
            DB::table('lectureimage')->insert(
                ['link'=>$static_link.$decoded->result->link,'lecture_id'=>$lecture_id]
            );
            $image_id = DB::table('lectureimage')->select('id')->where('link',$static_link.$decoded->result->link)->get();
            $image_id = $image_id[0]->id;
            // $lecture_id = DB::table('lectureimage')->select('lecture_id')->where('id',$image_id)->get();
            foreach ($decoded->result->detected as $student_id){
                // echo "<br>".$student_id->id;
                DB::table('lectureimagebystudent')->insert(
                    ['lectureimage_id'=>$image_id,'student_id'=>$student_id->id]
                );
                DB::table('attendancelist')->insert(
                    ['student_id'=>$student_id->id,'class_id'=>'IT4091','lecture_id'=>$lecture_id]
                );
            } 
        }   
        return redirect()->route('home');
    }

    public function showFolder(){
        $lectures = DB::table('lecture')->where('class_id','IT4091')->get();
        return view('class.show_folder')->with('lectures',$lectures);
    }

    public function showImage($id){
        $lectureimages = DB::table('lectureimage')->where('lecture_id',$id)->get();
        return view('class.show_image')->with('images',$lectureimages);
        // return view('class.show_image');
    }
}
