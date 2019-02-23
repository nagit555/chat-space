$(function() {

  function buildSearchUserListHtml(user) {
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

  function buildAddedUserListHtml(userId, userName) {
    var addedUserListHtml = `
                            <div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
                            <input name='group[user_ids][]' type='hidden' value='${userId}'>
                            <p class='chat-group-user__name'>${userName}</p>
                            <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn' data-user-id="${userId}">削除</a>
                            </div>`
    return addedUserListHtml;
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
          if ($('input[value="' + user.id + '"]').length === 0) {
            userListHtml = buildSearchUserListHtml(user);
            $('#user-search-result').append(userListHtml);
          }
        })
      } else {
        $('#user-search-result').append(buildNotFoundHtml());
      }
    })
    .fail(function() {
      alert('ユーザー検索に失敗しました');
    })
  });

  $(document).on("click", '.chat-group-user__btn--add', function() {
    var userId = $(this).attr('data-user-id');
    var userName = $(this).attr('data-user-name');
    var addedUserListHtml = buildAddedUserListHtml(userId, userName);
    $('#chat-group-users').append(addedUserListHtml);
    $('.user-search-add[data-user-id="' + userId + '"]').parent().remove();
  })

  $(document).on("click", '.chat-group-user__btn--remove', function() {
    var userId = $(this).attr('data-user-id');
    $('.user-search-remove[data-user-id="' + userId + '"]').parent().remove();
  })
});
