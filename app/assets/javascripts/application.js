// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
  //= require turbolinks
  //= require jquery
  //= require bootstrap-sprockets
  //= require_tree .


// チャット
$(function(){
  $(document).on('click', '.comment_submit', function(e){
    //空のフォームを送信できないようにする
    if ($('[name="comment[comment_text]"]').val() == ''){
      return false;
    }
  })
  $(document).on('ajax:success', '.comment_form', function(e){
    // console.log('-----始まり------');
    console.log(e);
    // console.log('-----終わり------');
    $('#comment_comment_text').val(''); //フォームを空にする
    $('.post_wrapper').prepend('<div class="comment_text"><strong>' + e.detail[0].user.name +'</strong><br>'+ e.detail[0].comment.comment_text + '<a class="comment_delete" data-remote="true" rel="nofollow" data-method="delete" href="/comments/'+ e.detail[0].comment.id +'">削除</a></div>');
  })
})


// コメント削除
$(function(){
  $('.comment_delete').on('ajax:success', function(e){
    console.log(e)
    $(this).closest('.comment_text').remove();
  })
})


// 写真の拡大表示・閉じる
$(function(){
  $('.photo_open_close').on('click', function(){
    $(this).toggleClass('active');
    var photoid = $(this).data('photoid');
    $(`.photo_show_js[data-photoid="${photoid}"]`).fadeToggle();
  });
});








