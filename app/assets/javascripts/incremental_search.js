$(function() {

  function buildUserListHtml(user) {
    var userListHtml = `<div class="chat-group-user clearfix">
                        <p class="chat-group-user__name">${user.name}</p>
                        <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
                        </div>`
    return userListHtml;
  }

  function buildNotFoundHtml() {
    var notFoundHtml = `<div class="chat-group-user clearfix">
                        <p class="chat-group-user__name">一致するユーザーが見つかりません</p>
                        </div>`
    return notFoundHtml;
  }

  $('#user-search-field').on('keyup', function() {
    var inputQuery =$(this).val();
    if (inputQuery === "") {
      $('#user-search-result').empty();
      return false;
    }

    $.ajax({
      url: '/users',
      type: "GET",
      data: { query: inputQuery },
      dataType: 'json',
    })
    .done(function(users) {
      $('#user-search-result').empty();
      var userListHtml;
      if (users.length !== 0) {
        users.forEach(function(user) {
          userListHtml = buildUserListHtml(user);
          $('#user-search-result').append(userListHtml);
        })
      } else {
        $('#user-search-result').append(buildNotFoundHtml());
      }
    })
    .fail(function() {
      alert('ユーザー検索に失敗しました');
    })
  });
});
