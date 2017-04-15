$("#bookmarks").html("<%= escape_javascript(render(bookmarks)) %>");
$("#paginator").html("<%= escape_javascript(paginate(bookmarks, remote: true).to_s) %>")
<% unless bookmarks.count.positive? %>
$("#bookmarks").html('There are no urls containing "<%= params[:search] %>".')
<% end %>
