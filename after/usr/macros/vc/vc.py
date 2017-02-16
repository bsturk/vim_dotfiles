################################################################################
#
# file:     vc.py
# purpose:  implements a "Norton Commander" style filemanager within vim
#
# author:   brian m sturk   bsturk@adelphia.net,
#                           http://users.adelphia.net/~bsturk
# created:  06/03/03
# last_mod: 08/16/04
# version:  0.01a
#
# usage, etc:   see vc.readme
# history:      see ChangeLog
# in the works: see TODO
#
###############################################################################

import vim, sys, re, os, shutil

##  If you're having a issue running vim_commander, please change 
##  the 0 to a 1 below and send me an email of the output.

_DEBUG_ = 0
cmdr    = None

################################################################################
##                             class vim_cmdr_panel                           ##
################################################################################

class vim_cmdr_panel:

    CWD_LINE_NUM      = 0
    HDR_END_LINE      = 2
    FILE_INFO_SPACING = 4
    SIZE_MAX          = 8

################################################################################

    def __init__( self, buf_name ):

        try:

            self.buffer_name = buf_name

            for b in vim.buffers:

                match = buf_name + '$'
                name  = b.name

                if name != None:
                    if re.search( match, name ):
                        self.buffer = b

            for w in vim.windows:
                if w != None:
                    if w.buffer == self.buffer:
                        self.window = w

            dbg_print( 'Creating panel for buffer ' + self.buffer_name )

            self.do_mappings()

            self.cwd              = os.getcwd()
            self.currently_tagged = []
            self.all_entries      = []

        except:

            dbg_exception( '__init__: exception!' )

################################################################################

    def populate_panel( self ):

        ## TODO: Support scrolling so the pwd always is in the top
        ##       line.

        self.do_hdr()

        ##  Non vc function call needs bookcase modifiable toggle

        vim.command( 'setlocal modifiable' )

        self.buffer.append( '' )

        vim.command( 'setlocal nomodifiable' )

        self.add_entries_to_buffer()

################################################################################

    def refresh( self ):

        dbg_print ( 'refresh: enter' )

        ##  TODO: At some point have a caching mechanism
        ##  NOTE: If the window is resized a redraw isn't triggered
        ##        There is no au for it yet

        ##  delete entire contents of buffers and refresh

        vim.command( 'setlocal modifiable' )

        del self.buffer[:]

        self.populate_panel()

        vim.command( 'setlocal nomodifiable' )
        vim.command( 'redraw' )

################################################################################

    def do_hdr( self ):

        vim.command( 'setlocal modifiable' )

        try:

            win_h = self.window.height
            win_w = self.window.width

            dbg_print( 'do_hdr: window height is ' + str( win_h ) )
            dbg_print( 'do_hdr: window width  is ' + str( win_w ) )

            horiz   = ' '
            leader  = '<- '
            trailer = ' ->'

            if self.is_current():
                leader  = '<+ '
                trailer = ' +>'

            num_to_fill = win_w - ( len( leader ) + len( trailer ) + len( self.cwd ) )

            ##  TODO:  Allow left/right justification here
            ##  TODO:  Truncate directory based on cfg option

            if num_to_fill > 0:
                line = leader + self.cwd + ( num_to_fill * horiz ) + trailer

            else:
                line = leader + self.cwd + trailer

            self.buffer[ self.CWD_LINE_NUM ] = line 

        except:

            dbg_exception( 'do_hdr: exception!' )

        vim.command( 'setlocal nomodifiable' )
            
################################################################################

    def add_entries_to_buffer( self ):

        vim.command( 'setlocal modifiable' )

        self.all_entries = []

        try:

            ##  TODO: Only add this if not in the root

            self.buffer.append( '..' + os.sep )     ## special entry
            self.all_entries.append( '..' + os.sep )

            dirs, others = self.get_dir_entries()

            dirs.sort()
            others.sort()

            ##  tuck them away for handling selections

            longest_name = self.longest_entry( others + dirs )

            ##  Do dirs first so they are at top

            for each in dirs:

                line = self.get_full_str( each, longest_name )
                self.buffer.append( line )

                self.all_entries.append( each )

            for each in others:

                ##  check for symlink, doesn't work
                ##  hilight_if_symlink( each )

                line = self.get_full_str( each, longest_name )
                self.buffer.append( line )

                self.all_entries.append( each )

        except Exception, e:

            dbg_exception( 'add_entries_to_buffer: exception!' )

        vim.command( 'setlocal nomodifiable' )

################################################################################

    def longest_entry( self, list ):
       
        long_len = 0

        for entry in list:
            tmp = len( entry )

            if tmp > long_len:
                long_len = tmp

        return long_len

################################################################################

    def get_full_str( self, entry, longest_entry ):

        fq_entry = os.path.join( self.cwd, entry )

        mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime = os.stat( fq_entry )

        num_spaces = ( longest_entry - len( entry ) ) + self.FILE_INFO_SPACING
        num_spaces = num_spaces + ( self.SIZE_MAX - len( str( size ) ) )
        spaces     = num_spaces * ' '

        tmp = entry + spaces + str( size )

        return tmp

################################################################################

    def hilight_if_symlink( self, entry ):

        tmp = os.path.join( self.cwd, each )

        print 'hilight_if_symlink: Enter'
        print tmp
        print

        try:

            if os.path.islink( tmp ):

                print 'hilight_if_symlink: is a link'
                print

                vim.command( 'let escaped = escape( "' + tmp + '", "." )' )
                escaped = vim.eval( "escaped" )

                dbg_print( 'add_entries_to_buffer: escaped selection is ' + escaped )

                vim.command( 'syn match vc_link "^' + escaped + '$"' )
                vim.command( 'hi def link vc_link WarningMsg' )
    
        except:

            print 'hilight_if_symlink: Exception'
            print

################################################################################

    def get_dir_entries( self ):

        entries = os.listdir( self.cwd )

        ## TODO: Expose this as sorting preference

        dirs   = []
        others = []

        for entry in entries:

            tmp = os.path.join( self.cwd, entry )

            if os.path.isdir( tmp ):
                entry = entry + os.sep
                dirs.append( entry )

            else:
                others.append( entry )

        return dirs, others

################################################################################

    def is_current( self ):

        vim.command( 'let our = bufwinnr( "' + self.buffer_name + '" )' )
        our_win = vim.eval( "our" )

        vim.command( 'let cur = winnr()' )
        cur_win = vim.eval( "cur" )

        if cur_win == our_win:
            dbg_print( 'is_current: Window ' + our_win + ' is the current window' )
            return True

        else:
            dbg_print( 'is_current: Window ' + our_win + ' is *not* the current window' )
            return False

################################################################################

    def get_current_line_sel( self ):

        entry = ''

        line, row = self.get_cur_cursor_pos()

        if line > self.HDR_END_LINE:

            ##  index is from top minux header, -1 for vim line always n-1, -1 for blank line separator

            index = line - self.HDR_END_LINE - 1

            entry = self.all_entries[ index ]

        return entry

################################################################################

    def default_action_handler( self ):

        dbg_print ( 'default_action_handler:' )

        sel = self.get_current_line_sel()

        if sel == '':
            return

        tmp = os.path.join( self.cwd, sel )

        if os.path.isdir( tmp ):
            dbg_print ( 'default_action_handler: Selection "' + sel + '" is a dir' )
            self.chdir( sel )

        elif os.path.isfile( tmp ):
            dbg_print ( 'default_action_handler: Selection "' + sel + '"is a file' )
            self.view( tmp )

        else:
            dbg_print ( 'default_action_handler: Selection "' + sel + ' " is something else' )

################################################################################

    def get_cur_cursor_pos( self ):

        # zero based

        cur_line, cur_row = self.window.cursor

        dbg_print( 'get_cur_cursor_pos: Line [' + str( cur_line ) + '] Row [' + str( cur_row ) + ']' )
        return cur_line, cur_row

################################################################################

    def chdir( self, new_dir ):

        ## Remove anything visual we added

        new_dir = self.remove_visual( new_dir )

        prev_cwd = self.cwd

        if new_dir == '..':

            entries  = os.path.split( self.cwd )
            new_dir  = entries[ 0 ]
            self.cwd = new_dir

        else:

            self.cwd = os.path.join( self.cwd, new_dir )

        dbg_print( 'chdir: Changing directory to ' + self.cwd )

        ## if directory changed remove tagged files

        if prev_cwd != self.cwd:
            self.unselect_all()

        ##  Also set vim's notion of cwd so commands can be done

        vim.command( 'cd ' + new_dir )

        self.refresh_window( False )

        self.goto_pos( self.HDR_END_LINE + 1 )

################################################################################

    def toggle_tag_handler( self ):

        ##  NOTE: Assumption here is that there cannot be 2 items with the exact
        ##        same name

        sel = self.get_current_line_sel()

        dbg_print( 'toggle_tag_handler: selection is ' + sel )

        if sel == '' or sel == ( ".." + os.sep ):
            return        # don't allow selecting that

        elif sel not in self.currently_tagged:

            ## selecting

            self.currently_tagged.append( sel )
            self.hilight_add( sel ) 

        else:

            ## de-selecting

            self.hilight_rm( sel ) 

        ##  TODO: Add config flag for going down by '1' after selection

        vim.command( 'normal j' )

################################################################################

    def hilight_add( self, sel ):

        vim.command( 'let escaped = escape( "' + sel + '", "." )' )
        escaped = vim.eval( "escaped" )

        dbg_print( 'toggle_tag_handler: escaped selection is ' + escaped )

        vim.command( 'syn match vc_selection "^' + escaped + '$"' )
        vim.command( 'hi def link vc_selection Visual' )

################################################################################

    def hilight_rm( self, sel ):

        dbg_print( 'hilight_rm: enter, sel is ' + sel )

        self.hilight_all_tagged( False )        # reset

        ##  Catches case where called and not selected.
        ##  Action when nothing is selected by tagging
        ##  is to use whereever the cursor is.

        if sel in self.currently_tagged:
            self.currently_tagged.remove( sel )

        self.hilight_all_tagged( True )

################################################################################

    def hilight_all_tagged( self, turn_on ):

        if turn_on:

            ## Escape since syntax stuff takes regular expressions

            for sel in self.currently_tagged:

                self.hilight_add( sel )
        else:

            if len( self.currently_tagged ) >= 1:
                vim.command( 'syn clear vc_selection' )
    
################################################################################

    def select_all( self ):

        dirs, files = self.get_dir_entries()

        entries = dirs + files

        for each in entries:

            if each not in self.currently_tagged and each != ( ".." + os.sep ):

                self.currently_tagged.append( each )

                self.hilight_add( each ) 

################################################################################

    def unselect_all( self ):

        self.hilight_all_tagged( False )
        self.currently_tagged = []

################################################################################

    def refresh_window( self, preserve_cursor = True ):

        cur_line, cur_row = self.window.cursor

        self.refresh()

        if preserve_cursor == True:
            self.goto_pos( cur_line )

################################################################################

    def view( self, filename = None, editable = False ):

        if filename == None:

            ##  Grab current selection

            file = self.remove_visual( self.get_current_line_sel() )

            filename = os.path.join( self.cwd, file )

        ##  NOTE: The double quotes are needed for files w/ spaces in their names

        vim.command( 'let escaped = escape( "' + filename + '", " " )' )
        escaped = vim.eval( "escaped" )

        if view_pwin == True:
            vim.command( 'pedit ' + escaped )

        else:
            vim.command( 'new ' + escaped )

        if editable == False:
            vim.command( 'setlocal readonly' )

################################################################################

    def copy( self, dest_panel ):

        dest_dir    = dest_panel.cwd
        src_entries = []
        copy_count  = 0

        dbg_print( 'copy: dest dir is ' + dest_dir )

        if self.currently_tagged == []:

            ## Nothing is selected so use where cursor is

            src = self.remove_visual( self.get_current_line_sel() )
            src_entries.append( src )

        else:

            for each in self.currently_tagged:

                each = self.remove_visual( each )
                src_entries.append( each )

        dbg_print( 'copy: src_entries are ' )
        dbg_print( src_entries )

        ##  TODO: It'd be nice to put up a progress dialog here, or use the |/\- stuff

        print "Copying file(s)..."

        for entry in src_entries:

            #mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime = os.stat( entry )

            fq_entry =  os.path.join( self.cwd, entry )

            if os.path.isdir( fq_entry ):

                dbg_print ( 'copy: entry "' + entry + '" is a dir' )

                new_dir = os.path.join( dest_dir, entry )

                try:
                    shutil.copytree( fq_entry, new_dir )

                except IOError, e:
                    print 'copy: IOError calling shutil.copytree with ' + fq_entry + ' ' + new_dir
                    print e

            else:

                if os.path.isfile( fq_entry ):
                    dbg_print ( 'copy: entry "' + entry + '" is a file' )

                else:
                    dbg_print ( 'copy: entry "' + entry + '" is something else' )

                try:

                    dest_entry =  os.path.join( dest_dir, entry )

                    if dest_entry == fq_entry:
                        print 'Cannot copy ' + dest_entry + ' to itself'
                        continue                    ## can't copy file to itself, plus python truncate bug, goto next

                    if os.path.exists( dest_entry ):

                        input_str = 'File \'' + dest_entry + ' already exists.  Overwrite? [y/n] : \n'
                        vim.command( 'let choice = inputdialog( "' + input_str + '" )' )
                        choice = vim.eval( "choice" )

                        if choice != 'y':
                            continue       ##  goto next entry

                    shutil.copy2( fq_entry, dest_dir )
                    copy_count += 1

                except Exception, e:
                    print 'copy: IOError calling shutil.copy2 with ' + fq_entry + ' ' + dest_dir
                    print e
            
        ##  Make copy of tagged list for iterating since it is modified by hilight_rm

        tmp_list = self.currently_tagged[:]

        for entry in tmp_list:
            self.hilight_rm( entry )

        print "Finished copying file(s)..."       ##  TODO: Get rid of 'hit enter' prompt here, and add copy_count

        self.refresh_window()
        dest_panel.refresh_window( False )

################################################################################

    def move( self, dest_panel ):

        dest_dir    = dest_panel.cwd
        src_entries = []
        move_count  = 0

        ##  2.3 supports move, check for it

        try:
            test_func = shutil.move
        except:
            print 'You must have python version 2.3 or above to use the move operation'
            print

            return

        dbg_print( 'move: dest dir is ' + dest_dir )

        if self.currently_tagged == []:

            ## Nothing is selected so use where cursor is

            src = self.remove_visual( self.get_current_line_sel() )
            src_entries.append( src )

        else:

            for each in self.currently_tagged:

                each = self.remove_visual( each )
                src_entries.append( each )

        dbg_print( 'move: src_entries are ' )
        dbg_print( src_entries )

        ##  TODO: It'd be nice to put up a progress dialog here, or use the |/\- stuff

        print "Moving file(s)..."

        for entry in src_entries:

            #mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime = os.stat( entry )

            fq_entry =  os.path.join( self.cwd, entry )

            if   os.path.isdir( fq_entry ):  dbg_print ( 'move: entry "' + entry + '" is a dir' )
            elif os.path.isfile( fq_entry ): dbg_print ( 'move: entry "' + entry + '" is a file' )
            else:                            dbg_print ( 'move: entry "' + entry + '" is something else' )

            try:

                dest_entry =  os.path.join( dest_dir, entry )

                if dest_entry == fq_entry:
                    continue                    ## can't move file/dir to itself, plus python truncate bug, goto next

                if os.path.exists( dest_entry ):

                    input_str = 'File \'' + dest_entry + ' already exists.  Overwrite? [y/n] : \n'
                    vim.command( 'let choice = inputdialog( "' + input_str + '" )' )
                    choice = vim.eval( "choice" )

                    if choice != 'y':
                        continue       ##  goto next entry

                shutil.move( fq_entry, dest_dir )
                move_count += 1

            except Exception, e:
                print 'move: Exception calling shutil.move with ' + fq_entry + ' ' + dest_dir
                print e
            
        ##  Make copy of tagged list for iterating since it is modified by hilight_rm

        tmp_list = self.currently_tagged[:]

        for entry in tmp_list:
            self.hilight_rm( entry )

        print "Finished moving file(s)..."       ##  TODO: Get rid of 'hit enter' prompt here, and add move_count

        self.refresh_window()
        dest_panel.refresh_window( False )

################################################################################

    def mkdir( self, other_panel ):

        vim.command( 'let dir = inputdialog( "Subdirectory name: " )' )
        dir = vim.eval( "dir" )

        if dir == '':
            return

        ##  TODO: Check for valid dirname
        ##        Set selection to newly made dir as an option

        new_dir = os.path.join( self.cwd, dir )

        try:
            os.mkdir( new_dir )

        except:
            print 'mkdir: Couldn\'t mkdir ' + new_dir
            return

        ## Refresh both panels for now, should be both only if in same dir

        self.refresh_window()
        other_panel.refresh_window( False )

################################################################################

    def rename( self, other_panel ):
        
        src_entry = None

        if self.currently_tagged == []:

            ## Nothing is selected so use where cursor is 
            src = self.remove_visual( self.get_current_line_sel() )
            src_entry =  src

        elif len( self.currently_tagged ) == 1:

                each = self.remove_visual( self.currently_tagged[0] )
                src_entry = each

        else:

            ##  More than one, not supported
            return

        vim.command( 'let new_name = inputdialog( "New name: \n" )' )
        new_name = vim.eval( "new_name" )

        if new_name == '':
            return

        fq_entry =  os.path.join( self.cwd, src_entry )
        os.rename( fq_entry, new_name )

################################################################################

    def remove( self, other_panel ):

        src_entries = []
        rm_count  = 0

        line, row = self.get_cur_cursor_pos()

        if self.currently_tagged == []:

            ## Nothing is selected so use where cursor is

            src = self.remove_visual( self.get_current_line_sel() )
            src_entries.append( src )

        else:

            for each in self.currently_tagged:

                each = self.remove_visual( each )
                src_entries.append( each )

        dbg_print( 'remove: src_entries are ' )
        dbg_print( src_entries )

        ##  TODO: It'd be nice to put up a progress dialog here, or use the |/\- stuff

        print "Removing file(s)..."

        for entry in src_entries:

            fq_entry =  os.path.join( self.cwd, entry )

            if   os.path.isdir( fq_entry ):  dbg_print ( 'remove: entry "' + entry + '" is a dir' )
            elif os.path.isfile( fq_entry ): dbg_print ( 'remove: entry "' + entry + '" is a file' )
            else:                            dbg_print ( 'remove: entry "' + entry + '" is something else' )

            try:

                if os.path.isdir( fq_entry ):

                    ##  TODO: Check if empty before confirming

                    input_str = 'Delete directory \'' + fq_entry + ' and all it\'s contents?  [y/n] : \n'
                    vim.command( 'let choice = inputdialog( "' + input_str + '" )' )
                    choice = vim.eval( "choice" )

                    if choice != 'y':
                        continue       ##  goto next entry

                    shutil.rmtree( fq_entry ) 

                else:
                    os.remove( fq_entry )

                rm_count += 1

            except Exception, e:
                print 'remove: Exception calling remove with ' + fq_entry
                print e
            
        ##  Make copy of tagged list for iterating since it is modified by hilight_rm

        tmp_list = self.currently_tagged[:]

        for entry in tmp_list:
            self.hilight_rm( entry )

        ## Refresh both panels for now, should be both only if in same dir

        self.refresh_window()
        other_panel.refresh_window( False )

        self.goto_pos( line )

################################################################################

    def remove_visual( self, entry ):

        ##  This routine cleans up selected entries which may have parts that
        ##  will interfere with operations, i.e. a trailing '/' on a directory name

        if entry[ -1 ] == os.sep:
            entry = entry[ : -1 ]
        
        return entry

################################################################################

    def goto_pos( self, line_num, col_num = None ):

        dbg_print( 'jumping to line ' + str( line_num ) )
        dbg_print( 'jumping to column ' + str( col_num ) )

        if col_num == None:
            dummy, col_num = self.get_cur_cursor_pos()

        dbg_print( 'setting to line ' + str( line_num ) )
        dbg_print( 'setting to column ' + str( col_num ) )

        ##  TODO: This should check the column too

        if line_num >= len( self.buffer ):
            line_num = len( self.buffer )

        self.window.cursor = line_num, col_num

################################################################################

    def do_mappings( self ):

        # TODO: These au crash vim on startup, get it to work so when leaving vc the buffer entered
        #       becomes the current one.  It works if I do it after everything has run.

        #vim.command( 'au BufEnter vc_panel_a :python enter_from_extern()<CR>' )
        #vim.command( 'au BufEnter vc_panel_b :python enter_from_extern()<CR>' )

        vim.command( 'nnoremap <buffer> ' + switch_pane_key +    ' :python cmdr.switch_panels()<CR>' )
        vim.command( 'nnoremap <buffer> ' + same_panel_key +     ' :python cmdr.same_panel()<CR>' )
        vim.command( 'nnoremap <buffer> ' + swap_panel_key +     ' :python cmdr.swap_panel()<CR>' )

        vim.command( 'nnoremap <buffer> ' + toggle_tag_key  +    ' :python cmdr.get_cur_panel().toggle_tag_handler()<CR>' )
        vim.command( 'nnoremap <buffer> ' + default_action_key + ' :python cmdr.get_cur_panel().default_action_handler()<CR>' )
        vim.command( 'nnoremap <buffer> ' + cd_up_key +          ' :python cmdr.get_cur_panel().chdir( ".." )<CR>' )

        vim.command( 'nnoremap <buffer> ' + select_all_key +     ' :python cmdr.get_cur_panel().select_all()<CR>' )
        vim.command( 'nnoremap <buffer> ' + unselect_all_key +   ' :python cmdr.get_cur_panel().unselect_all()<CR>' )

        vim.command( 'nnoremap <buffer> ' + refresh_key +        ' :python cmdr.get_cur_panel().refresh_window()<CR>' )
        vim.command( 'nnoremap <buffer> ' + view_key +           ' :python cmdr.get_cur_panel().view()<CR>' )
        vim.command( 'nnoremap <buffer> ' + edit_key +           ' :python cmdr.get_cur_panel().view( editable = False )<CR>' )
        vim.command( 'nnoremap <buffer> ' + copy_key +           ' :python cmdr.get_cur_panel().copy( cmdr.get_alt_panel() )<CR>' )
        vim.command( 'nnoremap <buffer> ' + move_key +           ' :python cmdr.get_cur_panel().move( cmdr.get_alt_panel() )<CR>' )
        vim.command( 'nnoremap <buffer> ' + mkdir_key +          ' :python cmdr.get_cur_panel().mkdir( cmdr.get_alt_panel() )<CR>' )
        vim.command( 'nnoremap <buffer> ' + rename_key +         ' :python cmdr.get_cur_panel().rename( cmdr.get_cur_panel() )<CR>' )
        vim.command( 'nnoremap <buffer> ' + remove_key +         ' :python cmdr.get_cur_panel().remove( cmdr.get_cur_panel() )<CR>' )
        vim.command( 'nnoremap <buffer> ' + quit_key +           ' :python cmdr.quit()<CR>' )

        vim.command( 'setlocal buftype=nofile' )
        vim.command( 'setlocal bufhidden=hide' )
        vim.command( 'setlocal noswapfile' )
        vim.command( 'setlocal tabstop=4' )
        vim.command( 'setlocal modifiable' )        ##  will be turned off when we're done writing buffer
        vim.command( 'setlocal nowrap' )
        vim.command( 'setlocal textwidth=999' )

        vim.command( 'syn match vc_pri_cwd "^<+.*$"' )
        vim.command( 'hi def link vc_pri_cwd String' )

        vim.command( 'syn match vc_alt_cwd "^<-.*$"' )
        vim.command( 'hi def link vc_alt_cwd Special' )

        vim.command( 'syn match vc_directory "^[^<].*/ \?"' )
        vim.command( 'hi def link vc_directory Directory' )

################################################################################
##                             class vim_cmdr                                 ##
################################################################################

class vim_cmdr:

    def __init__( self ):

        self.panel_a      = None
        self.panel_b      = None
        self.filename_pri = 'vc_panel_a'
        self.filename_alt = 'vc_panel_b'

        self.new_session()

################################################################################

    def sigint_handler( self, sig, frame ):

        dbg_print( 'sigint_handler: caught SIGINT' )
        dbg_print( '' )

################################################################################

    def new_session( self ):

        ##  TODO: Only allow one session, use a g:var for it

        vim.command( 'filetype on' )

        try:

            ##  NOTE: This must happen in this order since mappings are done for
            ##        both buffers in constructor for vim_cmdr_panel.

            if startup_new_win == True:
                vim.command( 'silent new ' + self.filename_alt )
            else:
                vim.command( 'silent edit ' + self.filename_alt )

            vim.command( 'setfiletype vim_commander' )

            self.panel_b = vim_cmdr_panel( self.filename_alt )

            #vim.command( 'set splitright' )                   ##  TODO: support splitbelow

            vim.command( 'silent vsplit ' + self.filename_pri )

            vim.command( 'setfiletype vim_commander' )

            self.panel_a = vim_cmdr_panel( self.filename_pri )

            self.panel_a.populate_panel()
            self.panel_b.populate_panel()

            self.panel_a.goto_pos( self.panel_a.HDR_END_LINE + 1 )

        except:

            dbg_exception( 'new_session: exception!' )

################################################################################

    def get_cur_panel( self ):

        if self.panel_a.is_current():
            dbg_print( 'get_cur_panel: A panel is current' )
            return self.panel_a

        if self.panel_b.is_current():
            dbg_print( 'get_cur_panel: B panel is current' )
            return self.panel_b

################################################################################

    def get_alt_panel( self ):

        if self.panel_a.is_current():
            dbg_print( 'get_alt_panel: B panel is alt' )
            return self.panel_b

        if self.panel_b.is_current():
            dbg_print( 'get_alt_panel: A panel is alt' )
            return self.panel_a

################################################################################

    def switch_panels( self ):

        vim.command( 'setlocal modifiable' )

        cur_panel = self.get_cur_panel()

        if cur_panel == self.panel_a:
            self.jump_to_panel( self.panel_b )

        else:
            self.jump_to_panel( self.panel_a )

        # Only need to redraw headers

        self.panel_a.do_hdr()
        self.panel_b.do_hdr()

        vim.command( 'setlocal nomodifiable' )

################################################################################

    def jump_to_panel( self, panel ):

        # Jump to the other panel on the same horizontal line if possible

        vim.command( 'let dummy = bufwinnr( "' + panel.buffer_name + '" )' )
        win_num = vim.eval( "dummy" )

        vim.command( win_num + ' wincmd w' )

        line, row = panel.get_cur_cursor_pos()

        if line <= panel.HDR_END_LINE:
            panel.goto_pos( panel.HDR_END_LINE + 1 )

        vim.command( 'cd ' + panel.cwd )

################################################################################

    def enter_panel_from_ext( self ):

        # A panel was entered from outside of vc

        dbg_print( 'enter_panel_from_ext: enter' )

        panel = get_cur_panel()

        self.jump_to_panel( panel, 0, 0 )

################################################################################

    def same_panel( self ):

        panel = self.get_cur_panel()

        if panel == self.panel_a:
            self.panel_b.cwd = self.panel_a.cwd
            self.panel_b.refresh()

        if panel == self.panel_b:
            self.panel_a.cwd = self.panel_b.cwd
            self.panel_a.refresh()

################################################################################

    def swap_panel( self ):

        #alt_panel = self.get_alt_panel()

        #vim.command( 'let dummy = bufwinnr( "' + alt_panel.buffer_name + '" )' )
        #win_num = vim.eval( "dummy" )

        #vim.command( win_num + ' wincmd x' )
        vim.command( 'wincmd r' )

################################################################################
##                           Helper functions                                 ##
################################################################################
        
def enter_from_extern():

    dbg_print( 'enter_from_extern: TODO' )

    #try:
    #    if cmdr != None:
    #        cmdr.enter_panel_from_ext()
    
    #except:
    #    dbg_print( 'enter_from_extern(): exception! ' + str( sys.exc_info()[0] ) )

################################################################################

def test_and_set( vim_var, default_val ):

    ret = default_val

    vim.command( 'let dummy = exists( "' + vim_var + '" )' )
    exists = vim.eval( "dummy" )

    ##  exists will always be a string representation of the evaluation

    if exists != '0':
        ret = vim.eval( vim_var )
        dbg_print( 'test_and_set: variable ' + vim_var + ' exists, using supplied ' + ret )

    else:
        dbg_print( 'test_and_set: variable ' + vim_var + ' doesn\'t exist, using default ' + ret )

    return ret

################################################################################

def dump_str_as_hex( _str ):

    hex_str = ''

    print 'length of string is ' + str( len( _str ) )

    for x in range( 0, len( _str ) ):
        hex_str = hex_str + hex( ord( _str[x] ) ) + "\n"

    print 'raw line ( hex ) is:'
    print hex_str

################################################################################

def dbg_print( _str ):

    if _DEBUG_:
        print _str
 
################################################################################

def dbg_exception( _str ):

    if _DEBUG_:
         print _str + ' ' + str( sys.exc_info( )[0] ) + str( sys.exc_info( )[1] )

################################################################################
##                           Main execution code                              ##
################################################################################

dbg_print( 'main: in main execution code' )

############################# customization ###################################
#
#  Don't edit the lines below, instead set the g:<variable> in your
#  .vimrc to the value you would like to use.  For numeric settings
#  *DO NOT* put quotes around them.  The quotes are only needed in
#  this script.  See vc.readme for more details
#
###############################################################################

###  Key mappings

switch_pane_key    = test_and_set( "g:vc_switch_pane_key",    "<Tab>" )
default_action_key = test_and_set( "g:vc_default_action_key", "<Enter>" )
same_panel_key     = test_and_set( "g:vc_same_panel_key",     "=" )
swap_panel_key     = test_and_set( "g:vc_swap_panel_key",     "+" )
cd_up_key          = test_and_set( "g:vc_cd_up_key",          "<Backspace>" )

refresh_key        = test_and_set( "g:vc_refresh_key",        "<F2>" )
view_key           = test_and_set( "g:vc_view_key",           "<F3>" )
edit_key           = test_and_set( "g:vc_edit_key",           "<F4>" )
copy_key           = test_and_set( "g:vc_copy_key",           "<F5>" )
move_key           = test_and_set( "g:vc_move_key",           "<F6>" )
mkdir_key          = test_and_set( "g:vc_mkdir_key",          "<F7>" )
remove_key         = test_and_set( "g:vc_remove_key",         "<F8>" )
rename_key         = test_and_set( "g:vc_rename_key",         "<F9>" )
quit_key           = test_and_set( "g:vc_quit_key",           "<F10>" )

toggle_tag_key     = test_and_set( "g:vc_toggle_tag_key",     "t" )
select_all_key     = test_and_set( "g:vc_select_all_key",     "T" )
unselect_all_key   = test_and_set( "g:vc_unselect_all_key",   "<C-t>" )

###  General Options

## use a new window when starting vc
# 0 to use current window for first panel and vsplit 2nd
# 1 create a new window for first panel and vsplit 2nd
#

startup_new_win = test_and_set( "g:vc_startup_new_win", "1" )

## type of window for viewing files
# 0 open a new regular vim buffer
# 1 use the preview window
#

view_pwin       = test_and_set( "g:vc_view_preview_win", "0" )

#############

try:
    cmdr = vim_cmdr()

except:
    dbg_print( 'main: exception! ' + str( sys.exc_info()[0] ) )
