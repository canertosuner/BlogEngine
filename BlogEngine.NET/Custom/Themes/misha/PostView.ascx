<%@ Control Language="C#" AutoEventWireup="true" EnableViewState="false" Inherits="BlogEngine.Core.Web.Controls.PostViewBase" %>
<%@ Import Namespace="BlogEngine.Core" %>
<%
    var singlePost = Location == ServingLocation.SinglePost;

    var postClass = "post-home";
    if (singlePost)
    {
        postClass = "post-single";
    }
    var postAdminLinks = "";
    if (AdminLinks.Length > 0)
    {
        postAdminLinks = "<div class=\"post-adminlinks\">" + AdminLinks + "</div>";
    }
    var postUrl = Post.RelativeOrAbsoluteLink;
    var postTitle = Server.HtmlEncode(Post.Title);
    var postDate = Post.DateCreated.ToString("MMM dd, yyyy");
    var authorUrl = Utils.AbsoluteWebRoot + "author/" + Utils.RemoveIllegalCharacters(Post.Author + BlogConfig.FileExtension);
    var authorName = Post.AuthorProfile != null ? Utils.RemoveIllegalCharacters(Post.AuthorProfile.DisplayName) : Utils.RemoveIllegalCharacters(Post.Author);
    var postCategory = CategoryLinks(", ");

    var postTags = "<div class=\"post-tags\">" + TagLinks(", ") + "</div>";

    // custom field for cover post
    var postFirstImage = Post.FirstImgSrc;
    var postImage = "<a class=\"post-cover\" href=\"" + postUrl + "\"><img src=\"" + Post.FirstImgSrc + "\" alt=\"" + postTitle + "\"></a>";

    if (!singlePost && postFirstImage.Length < 1)
    {
        postClass = "post-home no-thumbnail";
    }
    var blogLogo = "[CUSTOMFIELD|THEME|misha|Publisher Logo|http://exampleblog.com/logo.png/]";

%>

<% if (!singlePost)
    { %>
<article class="post <%=postClass %>" id="post<%=Index %>">
    <% if (postFirstImage.Length > 1)
        { %><%=postImage %><%} %>
    <header class="post-header">
        <h2 class="post-title"><a class="post-link" href="<%=postUrl %>"><%=postTitle %></a></h2>
        <div class="post-meta">
            <span class="post-author">By <a href="<%=authorUrl %>"><%=authorName %></a></span>
            <span class="post-date">/ <%=postDate %></span>
            <% if (postCategory.Length > 0)
                {%>/ <span class="post-category"><%=postCategory %></span><% } %>
        </div>
    </header>
    <section class="post-body">
        <p><%=Utils.StripHtml(Post.Description) %>...</p>
        <a class="post-more btn btn-sm btn-outline-primary" href="<%=postUrl %>">Read More</a>
    </section>
</article>
<%} %>


<% if (singlePost)
    { %>
<article class="post <%=postClass %>" id="post<%=Index %>">
    <header class="post-header">
        <h1 class="post-title"><a class="post-link" href="<%=postUrl %>"><%=postTitle %></a></h1>
        <div class="post-meta">
            <span class="post-author">By <a href="<%=authorUrl %>"><%=authorName %></a></span>
            <span class="post-date">/ <%=postDate %></span>
            <% if (postCategory.Length > 0)
                {%>/ <span class="post-category d-none d-sm-inline"><%=postCategory %></span> <% } %>
            <div class="dropdown post-share float-md-right">
                <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-share-alt"></i>share</a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item item-fb" href="https://www.addtoany.com/add_to/facebook?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-facebook-square"></i>Facebook</a>
                    <a class="dropdown-item item-tw" href="https://www.addtoany.com/add_to/twitter?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-twitter-square"></i>Twitter</a>
                    <a class="dropdown-item item-gp" href="https://www.addtoany.com/add_to/google_plus?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-google-plus-square"></i>Google +</a>
                    <a class="dropdown-item item-ln" href="https://www.addtoany.com/add_to/linkedin?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-linkedin-square"></i>LinkedIn</a>
                    <a class="dropdown-item item-pi" href="https://www.addtoany.com/add_to/pinterest?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-pinterest-square"></i>Pinterest</a>
                    <a class="dropdown-item item-em" href="https://www.addtoany.com/add_to/email?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-envelope-square"></i>Email</a>
                    <a class="dropdown-item item-em" href="https://www.addtoany.com/share?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-plus-square"></i>Share...</a>
                </div>
            </div>
        </div>
    </header>
    <section class="post-body content-stlye">
        <asp:PlaceHolder ID="BodyContent" runat="server" />
    </section>
    <footer class="post-footer">
        <%=postTags %>
        <%=postAdminLinks %>
    </footer>
</article>

<script type="application/ld+json">
    {
      "@context": "http://schema.org",
      "@type": "NewsArticle",
      "mainEntityOfPage": {
        "@type": "WebPage",
        "@id": "<%=Post.AbsoluteLink %>"
      },
      "headline": "<%=postTitle %>",
      <% if (postFirstImage.Length > 1)
    {%>"image": "<%=Utils.AbsoluteWebRoot + postFirstImage.TrimStart(' ', '/') %>",<%} %>
      "datePublished": "<%=Post.DateCreated.ToString("yyyy-MM-dd") %>",
      "dateModified": "<%=Post.DateModified.ToString("yyyy-MM-dd") %>",
      "author": {
        "@type": "Person",
        "name": "<%=authorName%>"
      },
       "publisher": {
        "@type": "Organization",
        "name": "<%=BlogSettings.Instance.Name %>",
        "logo": {
          "@type": "ImageObject",
          "url": "<%= blogLogo %>"
        }
      },
      "description": "<%=Utils.RemoveHtmlWhitespace(Post.Description)%>"
    }
</script>

<%} %>
