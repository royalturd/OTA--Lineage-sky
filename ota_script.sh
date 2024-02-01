device="sky"
product_out_path="../out/target/product/$device"

script_path="`dirname \"$0\"`"
buildprop=$script_path/$product_out_path/system/build.prop

if [ -f $script_path/$device.json ]; then
  rm $script_path/$device.json
fi

datetime=`grep "ro.system.build.date.utc=" $buildprop | cut -d'=' -f2`
version=`grep "ro.lineage.version=" $buildprop | cut -d'=' -f2`
build_version=`grep "ro.lineage.build.version=" $buildprop | cut -d'=' -f2`
zip_name="lineage-$version.zip"

zip_only=`basename $product_out_path/"$zip_name"`
md5=`md5sum $product_out_path/"$zip_name" | cut -d' ' -f1`
size=`stat -c "%s" $product_out_path/"$zip_name"`
romtype=`grep "ro.lineage.releasetype=" $buildprop | cut -d'=' -f2`

echo '{
  "response": [
    {
      "datetime": '$datetime',
      "filename": "'$zip_only'",
      "id": "'$md5'",
      "romtype": "'$romtype'",
      "size": '$size',
      "url": "https://downloads.pulkit077.workers.dev/0:/Downloads/'$zip_only'",
      "version": "'$build_version'"
    }
  ]
}' >> $device.json
