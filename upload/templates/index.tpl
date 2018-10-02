{nocache}
  {include file='templates/modules/header.tpl'}
{/nocache}

<div class="main">
  <div class="main-inner">
    <div class="container">
      <div class="row">
        <!-- /span6 -->
        <div class="span6" style="width: 100%;">
          <div class="widget">
            <div class="widget-header"> <i class="icon-bookmark"></i>
              <h3>Features</h3>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              {nocache}
                <h1>Hello, {$userName}!</h1>
                <div class="shortcuts">
                  <br />
                  <h3>My shortcuts</h3><br />
                  <div style="margin-top: -20px;"><a href="shortcuts.php?appID={$appID}" style="color: {$colorHeaderBackground}; text-decoration: underline;">Customize</a></div><br />
                  {foreach from=$keys item=i}
                    {if $shortcutTargets[$i] != "-"}
                      <a href="{$shortcutTargets[$i]}" class="shortcut"><i class="shortcut-icon icon-{$shortcutIcons[$i]}" style="color: #{$shortcutIconColors[$i]};"></i><span class="shortcut-label">{$shortcutTexts[$i]}</span></a>
                    {else}
                      No items to display.
                    {/if}
                  {/foreach}
                  <hr />
                  <h3>Personal services</h3><br />
                  <div style="margin-top: -20px;">Features you have access to</div><br />
                  {foreach from=$keys1 item=i}
                    {if $personalTargets[$i] != "-"}
                      <a href="{$personalTargets[$i]}" class="shortcut"><i class="shortcut-icon icon-{$personalIcons[$i]}" style="color: #{$personalIconColors[$i]};"></i><span class="shortcut-label">{$personalTexts[$i]}</span></a>
                    {else}
                      No items to display.
                    {/if}
                  {/foreach}
                  <hr />
                  <h3>Common services</h3><br />
                  <div style="margin-top: -20px;">Features every user has access to</div><br />
                  {foreach from=$keys2 item=i}
                    {if $commonTargets[$i] != "-"}
                      <a href="{$commonTargets[$i]}" class="shortcut"><i class="shortcut-icon icon-{$commonIcons[$i]}" style="color: #{$commonIconColors[$i]};"></i><span class="shortcut-label">{$commonTexts[$i]}</span></a>
                    {else}
                      No items to display.
                    {/if}
                  {/foreach}
                  <hr />
                  <h3>Personal services (example)</h3><br />
                  <div style="margin-top: -20px;">Features you have access to</div><br />
                  <a href="https://connect.woborschil.net" class="shortcut"><i class="shortcut-icon icon-off" style="color: #91c861;"></i><span class="shortcut-label">intraConnect</span></a>
                  <a href="https://connect.woborschil.net/nextcloud/index.php" class="shortcut"><i class="shortcut-icon icon-cloud" style="color: #0082c9;"></i><span class="shortcut-label">Nextcloud</span></a>
                  <a href="https://intra.woborschil.net/playground" class="shortcut"><i class="shortcut-icon icon-beaker" style="color: #f0a315;"></i><span class="shortcut-label">Playground</span></a>
                  <a href="https://intra.woborschil.net/efront" class="shortcut"><i class="shortcut-icon icon-edit" style="color: #274361;"></i><span class="shortcut-label">eFront</span></a>
                  <br />
                  <a href="https://intra.woborschil.net/forms" class="shortcut"><i class="shortcut-icon icon-check" style="color: #396b9e;"></i><span class="shortcut-label">Form Tools</span></a>
                  <a href="https://intra.woborschil.net/humhub" class="shortcut"><i class="shortcut-icon icon-share" style="color: #1565c0;"></i><span class="shortcut-label">HumHub</span></a>
                  <a href="https://intra.woborschil.net/phpmyadmin" class="shortcut"><i class="shortcut-icon icon-sitemap" style="color: #666699;"></i><span class="shortcut-label">phpMyAdmin</span></a>
                  <a href="https://intra.woborschil.net/feed" class="shortcut"><i class="shortcut-icon icon-bookmark" style="color: #56ae56;"></i><span class="shortcut-label">Feed Builder</span></a>
                  <br />
                  <a href="https://intra.woborschil.net/piwik" class="shortcut"><i class="shortcut-icon icon-bar-chart" style="color: #d42a1f;"></i><span class="shortcut-label">Piwik</span></a>
                  <a href="https://intra.woborschil.net/link/admin" class="shortcut"><i class="shortcut-icon icon-link" style="color: #2a85b3;"></i><span class="shortcut-label">URL Shortener</span></a>
                  <a href="https://intra.woborschil.net/phpqrcode" class="shortcut"><i class="shortcut-icon icon-qrcode" style="color: black;"></i><span class="shortcut-label">QR Code-Generator</span></a>
                  <a href="https://intra.woborschil.net/soundboard" class="shortcut"><i class="shortcut-icon icon-volume-up" style="color: #03a9f4;"></i><span class="shortcut-label">Soundboard</span></a>
                  <br />
                  <a href="https://webnas.woborschil.net/MyWeb/public/direct/VBTutorials/" class="shortcut"><i class="shortcut-icon icon-facetime-video" style="color: #87a6c7;"></i><span class="shortcut-label">Dev-Tutorials</span></a>
                  <a href="https://intra.woborschil.net/survey" class="shortcut"><i class="shortcut-icon icon-comments-alt" style="color: #0f9f31;"></i><span class="shortcut-label">LimeSurvey</span></a>
                  <hr />
                  <h3>Common services (example)</h3><br />
                  <div style="margin-top: -20px;">Features every user has access to</div><br />
                  <a href="http://www.woborschil.de" class="shortcut"><i class="shortcut-icon icon-globe" style="color: #1565c0;"></i><span class="shortcut-label">woborschil.de</span></a>
                  <a href="https://intra.woborschil.net/forum" class="shortcut"><i class="shortcut-icon icon-group" style="color: #0288d1;"></i><span class="shortcut-label">Forum</span></a>
                  <a href="https://intra.woborschil.net/wiki" class="shortcut"><i class="shortcut-icon icon-book" style="color: #bf360c;"></i><span class="shortcut-label">Wiki</span></a>
                  <a href="https://intra.woborschil.net/blog" class="shortcut"><i class="shortcut-icon icon-indent-right" style="color: #20789a;"></i><span class="shortcut-label">Blog</span></a>
                  <br />
                  <a href="https://intra.woborschil.net/docs" class="shortcut"><i class="shortcut-icon icon-file" style="color: #89bf0c;"></i><span class="shortcut-label">Docs</span></a>
                  <a href="https://intra.woborschil.net/git" class="shortcut"><i class="shortcut-icon icon-code" style="color: #1565c0;"></i><span class="shortcut-label">Git</span></a>
                  <a href="https://intra.woborschil.net/project" class="shortcut"><i class="shortcut-icon icon-tasks" style="color: #ff7b00;"></i><span class="shortcut-label">Project</span></a>
                  <a href="https://intra.woborschil.net/guide" class="shortcut"><i class="shortcut-icon icon-book" style="color: #328618;"></i><span class="shortcut-label">Guide</span></a>
                  <hr />
                  <h3>User actions</h3><br />
                  <a href="settings.php?appID={$appID}" class="shortcut"><i class="shortcut-icon icon-cog" style="color: #1565c0;"></i><span class="shortcut-label">My settings</span></a>
                  <a href="logout.php?appID={$appID}" class="shortcut"><i class="shortcut-icon icon-signout" style="color: #b71c1c;"></i><span class="shortcut-label">Log out</span></a>
                </div>
              {/nocache}
              <!-- /shortcuts -->
            </div>
            <!-- /widget-content -->
          </div>
          <!-- /widget -->
        </div>
        <!-- /span6 -->
      </div>
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /main-inner -->
</div>
<!-- /main -->

{nocache}
  {include file='templates/modules/footer.tpl'}
{/nocache}
