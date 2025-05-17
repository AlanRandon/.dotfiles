// hide comments with emoji

const observer = new MutationObserver(() => {
  const commentList = document.documentElement.querySelector(
    "ytd-comments #contents",
  );

  if (commentList !== null) {
    observer.disconnect();

    const commentsObserver = new MutationObserver(() => {
      for (const comment of commentList.querySelectorAll(
        "ytd-comment-thread-renderer",
      )) {
        if (!comment.dataset.commentChecked) {
          comment.dataset.commentChecked = true;

          const text = comment.querySelector("#content-text")?.innerHTML;
          if (text) {
            if (/\p{Emoji}|<img/u.test(text)) {
              comment.querySelector("#content-text").textContent =
                "emoji removed";
            }
          }
        }
      }
    });

    commentsObserver.observe(commentList, { childList: true });
  }
});

observer.observe(document.documentElement, { childList: true, subtree: true });
