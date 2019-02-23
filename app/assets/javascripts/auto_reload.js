$(function() {
  if ($('.UserMessage').length === 0) { return false; }

  function convertTimestamp(timestamp) {
    year = timestamp.getFullYear();
    month = ('0' + (timestamp.getMonth() + 1)).slice(-2);
    date = ('0' + timestamp.getDate()).slice(-2);
    hours = ('0' + timestamp.getUTCHours()).slice(-2);
    minutes = ('0' + timestamp.getMinutes()).slice(-2);
    seconds = ('0' + timestamp.getSeconds()).slice(-2);
    return `${year}-${month}-${date} ${hours}:${minutes}:${seconds} UTC`;
  }

  function buildMessageHTML(message) {
    imageElement = message.image.url ? `<img src="${message.image.url}">` : ""
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

  function reloadMessages() {
    $.ajax({
      url: location.href,
      type: "GET",
      data: "",
      dataType: 'json'
    })
    .done(function(messages) {
      var countNewMessages = messages.length - $('.UserMessage').length;
      var newMessages = countNewMessages ? messages.slice(-countNewMessages) : "";
      if (newMessages.length != 0) {
        newMessages.forEach(function(newMessage) {
          var messageHtml = buildMessageHTML(newMessage);
          $('.GroupMessage').append(messageHtml)
        })
        $('.GroupMessage').animate({scrollTop: $('.GroupMessage')[0].scrollHeight}, 'fast');
      }
    })
    .fail(function() {
      alert('error');
    })
  }

  setInterval(reloadMessages, 5000);
})
