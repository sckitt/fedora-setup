### FRONTEND REDIRECT

profile_youtube="/home/user/.mozilla/firefox/PLACEHOLDER.youtube"
profile_sns="/home/user/.mozilla/firefox/PLACEHOLDER.social-media"

first_parties=('youtube.com' 'twitter.com' 'instagram.com')
third_parties=('invidious.tube' 'nitter.net' 'bibliogram.art')

case ${1} in
    *"${first_parties[0]}"*) # access youtube via invidious
        firefox --profile "${profile_youtube}" "${1/${first_parties[0]}/${third_parties[0]}}"
        ;;
    *"${first_parties[1]}"*) # access twitter via nitter
        firefox --profile "${profile_sns}" "${1/${first_parties[1]}/${third_parties[1]}}"
        ;;
    *"${first_parties[2]}"*) # access instagram via bibliogram
        firefox --profile "${profile_sns}" "${1/${first_parties[2]}/${third_parties[2]}}"
        ;;
    *)
        ;;
esac