# https://margiolis.net/en/w/mutt_gmail_outlook/

set from = "Alan Randon <alan.randon@outlook.com>"
set realname = "Alan Randon"
set imap_user = "alan.randon@outlook.com"

set smtp_url = "smtp://alan.randon@outlook.com@smtp.office365.com:587"
set folder = "imaps://alan.randon@outlook.com@outlook.office365.com"

set smtp_authenticators = "xoauth2"
set imap_authenticators = "xoauth2"
set ssl_starttls = yes
set ssl_force_tls = yes

set my_pass = "`pass outlook`"
set imap_pass = $my_pass
set smtp_pass = $my_pass

set imap_oauth_refresh_command = "~/scripts/mutt_oauth2.py ~/.config/neomutt/outlooktoken"
set smtp_oauth_refresh_command = "~/scripts/mutt_oauth2.py ~/.config/neomutt/outlooktoken"

set spoolfile = "+INBOX"
set record = "+Sent Items"
set postponed = "+Drafts"
set trash = "+Deleted (Neomutt)"

mailboxes =INBOX ="Sent Items" =Drafts ="Deleted (Neomutt)" ="Archive"

# vim: ft=muttrc
