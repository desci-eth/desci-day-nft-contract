counter=0
find $(pwd) -iname "*.png" | while read f
do
    mv -v "${f}" "$(printf '%s/tulip_%04d.png' $(pwd) ${counter})"
    ((counter=counter+1))
done