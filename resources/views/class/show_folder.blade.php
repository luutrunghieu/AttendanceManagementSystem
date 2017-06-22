@extends('layouts.master')

@section('head.title')
Danh sách lớp
@stop

@section('body.content')
<div class="container">
    <div class="row">
        @foreach($lectures as $lecture)
            <div class="col-md-4 col-sm-4">
                <a href="{{route('showImage',$lecture->id)}}">
                    <img class="folder" src="images/folder.jpg" alt="">
                    <p class="lecture">Buổi {{$lecture->id}}</p>
                </a>
            </div>
        @endforeach
        <a href="{{route('home')}}"><button class="btn btn-primary btn-back">BACK</button></a>
    </div>
</div>
@stop