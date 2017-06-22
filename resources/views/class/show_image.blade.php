@extends('layouts.master')

@section('head.title')
Danh sách lớp
@stop

@section('body.content')
<div class="container">
    <div class="row">
        @foreach($images as $image)
            <div class="col-md-4 col-sm-4 col-xs-12">
                <img src="{{$image->link}}" class="myImg img-responsive">
            </div>
        @endforeach
        <!-- The Modal -->
        <a href="{{route('showFolder')}}"><button class="btn btn-primary btn-back">BACK</button></a>
            <div id="myModal" class="modal">
                <span class="close">&times;</span>
                <img class="modal-content" id="img01">
                <div id="caption"></div>
            </div>
    </div>
</div>



@stop