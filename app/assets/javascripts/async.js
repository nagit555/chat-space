$(function() {

  function convertTimestamp(timestamp) {
    year = timestamp.getFullYear();
    month = ('0' + (timestamp.getMonth() + 1)).slice(-2);
    date = ('0' + timestamp.getDate()).slice(-2);
    hours = ('0' + timestamp.getUTCHours()).slice(-2);
    minutes = ('0' + timestamp.getMinutes()).slice(-2);
    seconds = ('0' + timestamp.getSeconds()).slice(-2);
    return `${year}-${month}-${date} ${hours}:${minutes}:${seconds} UTC`;
  }

  function messageHTML(message) {
    if (message.image.url == null) {
      imageElement = ""
    } else {
      imageElement = `<img src="${message.image.url}">`
    }
    message_date = convertTimestamp(new Date(message.created_at));
    var html = `<div class="UserMessage">
                  <span class="UserMessage__user-name">
                    ${message.user_name}
                  </span>
                  <span class="UserMessage__posted-at">
                    ${message_date}
                  </span>
                  <div class="UserMessage__content">
                    ${message.body}
                    ${imageElement}
                  </div>
                </div>`
    return html;
  }

  $('.GroupPost').on('submit', function(e) {
    //e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = messageHTML(data);
      $('.GroupMessage').append(html)
      $('.GroupPost__text-form').val('')
    })
    .fail(function() {
      alert('error');
    })
    $('.GroupMessage').animate({scrollTop: $('.GroupMessage')[0].scrollHeight}, 'fast');
    $('.GroupPost__text-form').focus();
    return false;
  });
});
