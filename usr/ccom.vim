set cindent
set cinoptions==0

iab za      assert ( );<C-O>2h
iab zc      catch ( )<CR>{<CR>}<C-O><Up><Up><C-O>f(<Right>
iab zd      do<CR>{<CR>}<CR>while ( );<C-O>2h
iab ze      else<CR>{<CR>}<Up><CR><BS>
iab zE      else if ( )<CR>{<CR>}<Up><Up><C-O>f(<Right>
iab zf      for (;;)<CR>{<CR>}<Up><Up><C-O>f(<Right>
iab zi      if ( )<CR>{<CR>}<C-O><Up><Up><C-O>f(<Right>
iab zp      public
iab zP      private 
iab zpr     protected
iab zr      return;<Left>
iab zs      switch ( )<CR>{<CR>case CHANGEME:<CR><TAB>break;<CR><CR>default:<CR>}<C-O>6k<C-O>f(<Right>
iab zt      //  TODO:
iab ztr     try<CR>{<CR>}<Up><CR><BS>
iab zw      while ( )<CR>{<CR>}<C-O><Up><Up><C-O>f(<Right>
iab zz      {<CR>}<Up>
iab z?      //////////////////////////////////////////////////////////////////////
iab z/      ///////////////////////////////////
iab z\      /*<CR><Tab>**********************************************************<CR><CR>**********************************************************<CR><C-D>*/<Up><Up><Tab>
iab z*      /******************************************************************************/
