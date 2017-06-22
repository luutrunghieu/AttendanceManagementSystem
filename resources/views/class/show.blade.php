@extends('layouts.master')

@section('head.title')
Danh sách lớp
@stop

@section('body.content')
<section>
    <div class="container-fluid">
        <div class="row main-content">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <table class="table">
                    @foreach($classes as $c)
                    <tr>
                        <td colspan='8'>
                        {{$c->name.' - '.$c->id}}
                        </td>
                    </tr>
                    @endforeach

                    @foreach($profs as $p)
                    <tr>
                        <td colspan='8'>Giảng viên giảng dạy:{{$p->name}}</td>
                    </tr>
                    @endforeach
                    {{--{{$students}}--}}
                    <tr>
                        <th>STT</th>
                        <th>MSSV</th>
                        <th>Tên sinh viên</th>
                        @for($i = 1;$i<=sizeof($lectures);$i++)
                            <th class="text-center">Buổi {{$i}}</th>
                        @endfor
                        <th class="text-center">Số ngày nghỉ</th>
                    </tr>
                    @foreach($students as $student)
                    <tr>
                        <td>{{$loop->index+1}}</td>
                        <td>{{$student->id}}</td>
                        <td>{{$student->name}}</td>
                        @for($i = 0;$i<sizeof($lectures);$i++)
                            @php
                                $exist = false;
                            @endphp
                            @foreach($student->attlist as $al)
                                @if($al->lecture_id == $i+1)
                                    @php
                                        $exist = true;
                                    @endphp
                                    <td class="text-center">X</td>
                                @endif
                            @endforeach
                            @if(!$exist)
                                <td class="text-center"></td>
                            @endif
                        @endfor
                        <td class="text-center">{{sizeof($lectures)-sizeof($student->attlist)}}</td>
                    </tr>
                    @endforeach
                    
                </table>
                <form class="form-inline" method="POST" enctype="multipart/form-data" action="{{route('attlist.update')}}">
                    <input type="hidden" name="_token" value="{{csrf_token() }}">
                    <div class="form-group">
                        <label for="lecturelist">Buổi:</label>
                        <select name="lecturelist">
                            @for($i = 1;$i<=sizeof($lectures);$i++)
                                <option value="{{$lectures[$i-1]->id}}">{{$i}}</option>
                            @endfor
                        </select>
                    </div>
                    <input type="file" id="file" name="photo">
                    <input class="btn btn-primary" id="submit" type="submit">
                </form>
                <a href="{{route('showFolder')}}"><button id="xem_anh" class="btn btn-primary">Xem ảnh</button></a>
            </div>
        </div>
        
        <div class="cssload-thecube">
            <div class="cssload-cube cssload-c1"></div>
            <div class="cssload-cube cssload-c2"></div>
            <div class="cssload-cube cssload-c4"></div>
            <div class="cssload-cube cssload-c3"></div>
        </div>
    </div>
</section>
@stop

