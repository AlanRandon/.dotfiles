if (
  /youtube\.com/.test(document.location.hostname) &&
  !document.documentElement.dataset.tridactylYoutubeScriptStarted
) {
  document.documentElement.dataset.tridactylYoutubeScriptStarted = true;

  console.log("[DEBUG]: youtube.js loaded");

  const observer = new MutationObserver(() => {
    console.log("[DEBUG]: youtube.js searching for comment element");

    const commentLists = document.documentElement.querySelectorAll(
      "ytd-comments > #sections > #contents",
    );

    for (const commentList of commentLists) {
      if (commentList.dataset.tridactylYoutubeScriptObserved) {
        continue;
      }

      commentList.dataset.tridactylYoutubeScriptObserved = true;
      console.log("[DEBUG]: youtube.js located comment element", commentList);

      const commentsObserver = new MutationObserver(() => {
        for (const comment of commentList.querySelectorAll(
          "ytd-comment-thread-renderer",
        )) {
          if (!comment.dataset.tridactylYoutubeScriptChecked) {
            comment.dataset.tridactylYoutubeScriptChecked = true;

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

  observer.observe(document.documentElement, {
    childList: true,
    subtree: true,
  });
}
