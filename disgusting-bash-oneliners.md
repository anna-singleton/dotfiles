# disgusting bash one liners
read at your own peril of your eyes

replace strings with enum and import the enum, ruff check to organise the imports.
```bash
export REPL='"app"'; export WITH='MEDIA_TYPES.APP'; for file in $(rg -l 'media_type = '"$REPL"); do sed -i "s/media_type = $REPL/media_type = $WITH/" $file; sed -i '1s;^;from crisp_scrapy_common.models.media_types import MEDIA_TYPES\n;' $file; ruff check --select I --fix $file; done;
```
